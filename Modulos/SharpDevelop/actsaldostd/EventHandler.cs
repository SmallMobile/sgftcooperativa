/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/12/12
 * Hora: 09:56 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System;
using System.Data;
using System.Timers;
using System.Text;
using FirebirdSql.Data.FirebirdClient;

namespace actsaldostd
{

	public class Clock
	{
		private Timer _clock;
		
		public Clock()
		{
			this._clock = new Timer();
			this._clock.Interval = globalvars.Interval;
			this._clock.Elapsed+=new System.Timers.ElapsedEventHandler(Timer_Tick);
			this._clock.Start();
		}
		
		private void Timer_Tick(object sender,System.Timers.ElapsedEventArgs eArgs)
		{
			if(sender==this._clock)
			{
				this._clock.Stop();
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Procesando Saldos...");
				this.Ciclo();
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Proceso Finalizado...");
				this._clock.Start();
			}
		}
		
		private void Ciclo()
		{
			string _cs;
			bool _send = false;
			FbConnectionStringBuilder Cs = new FbConnectionStringBuilder();
			FbConnection _conn;
			FbTransaction _tran;
			FbCommand _query;
			FbDataReader _reader;
			
			Cs.Database = globalvars.database;
			Cs.DataSource = globalvars.server;
			Cs.UserID = globalvars.user;
			Cs.Password = globalvars.password;
			Cs.Charset = "ISO8859_1";
			Cs.Dialect = 3;
			
			_cs = Cs.ToString();
			
			_conn = new FbConnection(_cs);
			_conn.Open();
			_tran = _conn.BeginTransaction();
			StringBuilder _querystr = new StringBuilder();
			_querystr.Append("select \"cap$tarjetasaldo\".*, \"cap$tarjetacuenta\".ID_TARJETA from \"cap$tarjetasaldo\"");
			_querystr.Append("inner join \"cap$tarjetacuenta\" on");
			_querystr.Append("(\"cap$tarjetasaldo\".ID_AGENCIA = \"cap$tarjetacuenta\".ID_AGENCIA)");
			_querystr.Append("and");
			_querystr.Append("(\"cap$tarjetasaldo\".ID_TIPO_CAPTACION = \"cap$tarjetacuenta\".ID_TIPO_CAPTACION)");
			_querystr.Append("and");
			_querystr.Append("(\"cap$tarjetasaldo\".NUMERO_CUENTA = \"cap$tarjetacuenta\".NUMERO_CUENTA)");
			_querystr.Append("and");
			_querystr.Append("(\"cap$tarjetasaldo\".DIGITO_CUENTA = \"cap$tarjetacuenta\".DIGITO_CUENTA)");
			_querystr.Append("where");
			_querystr.Append("\"cap$tarjetacuenta\".ID_ESTADO in (1,2)");
			_query = new FbCommand(_querystr.ToString(),_conn,_tran);
			try
			{
				_query.Prepare();
			}
			catch(FbException e)
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Error en el Prepare 1..." + e.Message);
			}
			
			try
			{
				_reader = _query.ExecuteReader();
				XmlFBParse _xmlparse = new XmlFBParse();
				while (_reader.Read())
				{
					stdData _data = new stdData();
					_data.id_agencia = _reader.GetInt32(_reader.GetOrdinal("ID_AGENCIA"));
					_data.id_tipo_captacion = _reader.GetInt32(_reader.GetOrdinal("ID_TIPO_CAPTACION"));
					_data.numero_cuenta = _reader.GetInt32(_reader.GetOrdinal("NUMERO_CUENTA"));
					_data.digito_cuenta = _reader.GetInt32(_reader.GetOrdinal("DIGITO_CUENTA"));
					_data.id_tarjeta = _reader.GetString(_reader.GetOrdinal("ID_TARJETA"));
					_data.saldo = _reader.GetDecimal(_reader.GetOrdinal("SALDO"));
					_data.disponible = _reader.GetDecimal(_reader.GetOrdinal("DISPONIBLE"));
					_xmlparse.AddQuery(_data);
					_reader.NextResult();
					_send = true;
				}
				_reader.Close();
				_reader.Dispose();
				
				if (_send){
					
					
					ClientTcp _tcpclient = new ClientTcp();
					_tcpclient.XmlString = _xmlparse.XmlString();
					if (_tcpclient.SendData())
					{
						// Borrar registros leidos y procesados
						_query = new FbCommand("delete from \"cap$tarjetasaldo\"",_conn,_tran);
						try
						{
							_query.Prepare();
						}
						catch(FbException e)
						{
							CreateLogFiles.ErrorLog(globalvars.Logfile,"Error en el Prepare 2..." + e.Message);
						}
						
						try
						{
							_query.ExecuteNonQuery();
						}
						catch(FbException e)
						{
							CreateLogFiles.ErrorLog(globalvars.Logfile,"Error en el Query 2..." + e.Message);
						}
					}
				}
				

			}
			catch (FbException e)
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Error en el Query 1..." + e.Message);
			}
			
			_query.Dispose();
			_tran.Commit();
			_tran.Dispose();
			_conn.Close();
			_conn.Dispose();
			
		}
	}

}
