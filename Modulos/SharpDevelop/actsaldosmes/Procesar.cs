/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/12/01
 * Hora: 10:00 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.Data;
using FirebirdSql.Data.FirebirdClient;

namespace actsaldosmes
{
	/// <summary>
	/// Description of Procesar.
	/// </summary>
	public class Procesar
	{
		public Procesar()
		{
		}

		public void Execute()
		{
			int[] _types = {1,2,4,5};
			int _year;
			int _yearant;
			int _period;
			DateTime _iniDate;
			DateTime _endDate;
			DateTime _today;
			
			_today = DateTime.Now;
			_year = _today.Year;
			_period = _today.Month;
			switch (_period)
			{
					case 1:{
						_yearant = _year - 1;
					}
					break;
					default:{
						_yearant = _year;
					}
					break;
			}
			
			_iniDate = new DateTime(_yearant,01,01);
			if (_yearant != _year){
				_endDate = new DateTime(_yearant,12,31);
			}
			else
			{
				_endDate = new DateTime(_year,(_period - 1),DateTime.DaysInMonth(_year,(_period - 1)));
			}
			
			FbConnectionStringBuilder _cs = new FbConnectionStringBuilder();
			_cs.DataSource = globalvars.server;
			_cs.Database = globalvars.database;
			_cs.UserID = globalvars.user;
			_cs.Password = globalvars.password;
			string cs = _cs.ToString();
			CreateLogFiles _log = new CreateLogFiles();
			
			FbConnection _conn = new FbConnection(cs);
			_conn.Open();
			FbTransaction _tran = _conn.BeginTransaction();
			string _logstring = "";
			
			foreach(int _i in _types)
			{
				FbCommand _query = new FbCommand("SELECT CONTEO FROM CREAR_SALDOSMES(@TIPO,@ANO,@PERIODO,@FECHAINICIAL,@FECHAFINAL)",_conn,_tran);
				_query.Parameters.Add("@TIPO",_i);
				_query.Parameters.Add("@ANO",_year);
				_query.Parameters.Add("@PERIODO",_period);
				_query.Parameters.Add("@FECHAINICIAL",_iniDate.Date.ToString("yyyy/MM/dd"));
				_query.Parameters.Add("@FECHAFINAL",_endDate.Date.ToString("yyyy/MM/dd"));
				_logstring = string.Format("Comando:SELECT CONTEO FROM PROCEDURE CREAR_SALDOMES({0},{1},{2},'{3}','{4}')",_i,_year,_period,_iniDate.Date.ToString("yyyy/MM/dd"),_endDate.Date.ToString("yyyy/MM/dd"));
				_log.ErrorLog(globalvars.Logfile,_logstring);
				FbDataReader _reader;
				_reader = _query.ExecuteReader();
				int _tcount = 0;
				if (_reader.Read()){
					_tcount = _reader.GetInt32(0);
				}
				_reader.Close();
				_reader.Dispose();
				_reader = null;
				_query.Dispose();
				_query = null;
				_logstring = string.Format("Resultado:{0} registros afectados",_tcount);
				_log.ErrorLog(globalvars.Logfile,_logstring);
			}
			_tran.Commit();
			_tran.Dispose();
			_tran = null;
			_conn.Close();
			_conn.Dispose();
			_conn = null;
			
		}
	}
}
