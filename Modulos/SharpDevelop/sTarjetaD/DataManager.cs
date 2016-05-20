/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/20
 * Hora: 04:45 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.Text;
using System.Xml;
using FirebirdSql.Data.FirebirdClient;

namespace sTarjetaD
{
	/// <summary>
	/// Description of DataManager.
	/// </summary>
	public class DataManager
	{
		// Datos para conexión a la base de datos
		private FbConnection _conn;
		private FbTransaction _tran;
		
		// Datos Tarjeta
		private int _returnport;
		private string _id;
		private string _date;
		private string _time;
		private string _secuence;
		private Mensajes _message;
		private Causal _causal;
		private string _card;
		private string _net;
		private decimal _ammount;
		private string _cuen;
		
		// Dato que me define si el valor a aplicar es un descuento o
		// un incremento
		private bool _esdescuento;  // este valor representa un ingreso de un valor positivo
		
		// Datos de uso interno
		private int _estado;
		private int _idagencia;
		private int _tipocuenta;
		private int _numerocuenta;
		private int _digitocuenta;
		private decimal _cupopos;
		private decimal _cupoatm;
		private string _datafono;
		
		// Datos Respuesta
		private Mensajes _msg;
		private Errores  _err;
		private decimal _ammount1;
		private decimal _ammount2;
		
		// Datos de Propiedades
		private byte[] _returndata;
		
		public byte[] Data {
			get { return _returndata; }
		}
		
		public int Returnport {
			get { return _returnport; }
		}

		
		public DataManager(byte[] _data)
		{
			XmlDocument _xmldoc = new XmlDocument();
			Encoding en = Encoding.ASCII;
			string _xmlstring = en.GetString(_data);
			FbConnectionStringBuilder _cs = new FbConnectionStringBuilder();
			// Cargar el string con el xml embebido
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Petición:"+_xmlstring);
			_xmldoc.LoadXml(_xmlstring);
			XmlNodeList _xmlnodelist = _xmldoc.GetElementsByTagName("DATA");
			XmlElement _xmlnode = (XmlElement)_xmlnodelist[0];
			// Extraer los valores del Xml
			this._returnport = Convert.ToInt32(_xmlnode.GetAttribute("PORT"));
			this._id = _xmlnode.GetAttribute("ID");
			this._date = _xmlnode.GetAttribute("DATE");
			this._time = _xmlnode.GetAttribute("TIME");
			this._secuence = _xmlnode.GetAttribute("SECUENCE");
			this._message = (Mensajes)Enum.ToObject(typeof(Mensajes),Convert.ToInt32(_xmlnode.GetAttribute("MESSAGE")));
			this._causal = (Causal)Enum.ToObject(typeof(Causal),Convert.ToInt32(_xmlnode.GetAttribute("CAUSAL")));
			this._card = _xmlnode.GetAttribute("CARD");
			this._net = _xmlnode.GetAttribute("NET");
			this._ammount = Convert.ToDecimal(_xmlnode.GetAttribute("AMMOUNT"));
			this._cuen = _xmlnode.GetAttribute("CUEN");
			
			if (this._net == "5")
			{
				this._datafono = this._secuence.Substring(2,6);
			}
			else
			{
				this._datafono = "";
			}
			
			_cs.DataSource = globalvars.server;
			_cs.Database = globalvars.database;
			_cs.UserID = globalvars.user;
			_cs.Password = globalvars.password;
			_cs.Charset = "ISO8859_1";
			_cs.Dialect = 3;
			
			string ConnectionString = _cs.ToString();
			
			this._conn = new FbConnection(ConnectionString);
			this._conn.Open();
			this._tran = _conn.BeginTransaction();
			
			Execute();
			
			if (this._err == Errores.Bien){
				this._tran.Commit();
			}
			else
			{
				this._tran.Rollback();
			}
			this._tran.Dispose();
			this._conn.Close();
			this._conn.Dispose();
			
			
		}
		
		private void Execute()
		{
			BuscarDatosTarjeta();
			
			switch (this._causal)
			{
				case Causal.Consulta1:
				case Causal.Consulta2:
				case Causal.Compra:
				case Causal.Retiro:
					CrearRespuestaConsulta();
					break;
				case Causal.Consignacion:
					CrearRespuestaConsignacion();
					break;
				case Causal.Anulacion:
					CrearRespuestaAnulacion();
					break;
					default: break;
			}
			
			EstablecerMensajeRespuesta();
			
			switch(this._message)
			{
				case Mensajes.Reintento_Peticion:
				case Mensajes.Re_Reintento_Peticion:
				case Mensajes.R_Reverso:
					InsertarMovimientoReintento(); // propenso a fallo
					break;
					default: break;
			}
			
			switch(this._causal)
			{
				case Causal.Compra:
				case Causal.Retiro:
				case Causal.Consignacion:
				case Causal.Anulacion:
					{
						if (this._err == Errores.Bien)
						{
							if (InsertarMovimientoTarjeta())
							{
								if (this._datafono != "")
								{
									InsertarMovimientoCaja();
								}
							}
							else
							{
								this._err = Errores.Invalida;
								this._ammount1 = 0;
								this._ammount2 = 0;
							}
						}
					}
					break;
					default: break;
			}
			
			
			// Crear xml de retorno
			XmlDocument _xmltemp = new XmlDocument();
			XmlElement _xmlnodetemp = _xmltemp.CreateElement("","ROW","");
			_xmlnodetemp.SetAttribute("ID",this._id);
			_xmlnodetemp.SetAttribute("CARD",this._card);
			_xmlnodetemp.SetAttribute("SECUENCE",this._secuence);
			_xmlnodetemp.SetAttribute("MESSAGE",Convert.ToString((int)this._msg));
			_xmlnodetemp.SetAttribute("ERROR",Convert.ToString((int)this._err));
			_xmlnodetemp.SetAttribute("AMMOUNT1",this._ammount1.ToString("#0"));
			_xmlnodetemp.SetAttribute("AMMOUNT2",this._ammount2.ToString("#0"));
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Respuesta:"+_xmlnodetemp.OuterXml);
			
			this._returndata =  Encoding.ASCII.GetBytes(_xmlnodetemp.OuterXml);
		}
		
		private void CrearRespuestaConsulta()
		{
			
			if (this._err == Errores.Bien)
			{
				// Establecer Saldos
				switch(this._message)
				{
					case Mensajes.Reverso:
					case Mensajes.R_Reverso:
						{
				//<TODO> Validar si ya existe un reverso equivalente y
				// responder con los mismos saldos sin aplicar la reversión
				//</TODO>
							// Es Reverso de una Compra o Retiro, aumenta el disponible
							this._ammount1 += this._ammount;
							this._ammount2 += this._ammount;
							this._esdescuento = false;
						}
						break;
					case Mensajes.Peticion:
					case Mensajes.Reintento_Peticion:
					case Mensajes.Re_Reintento_Peticion:
						{
				//<TODO> Validar si ya existe una petición equivalente y
				// responder con los mismo sin aplicar movimiento
				//</TODO>
							if (this._ammount2 < this._ammount)
							{
								this._err = Errores.Insuficiente;
							}
							else
							{
								// Es una Compra o Retiro, disminuye el disponible
								this._ammount1 -= this._ammount;
								this._ammount2 -= this._ammount;
								this._esdescuento = true;
							}
						}
						break;
				}
				// Estableces Mensaje de Respuesta
			}
		}
		
		private void CrearRespuestaAnulacion()
		{
			if (this._err == Errores.Bien)
			{
				// Establecer Saldos
				switch(this._message)
				{
					case Mensajes.Reverso:
					case Mensajes.R_Reverso:
						{
							// Es Reverso de una Anulación de una Compra o Retiro, disminuye el disponible
							this._ammount1 -= this._ammount;
							this._ammount2 -= this._ammount;
							this._esdescuento = true;
						}
						break;
					case Mensajes.Peticion:
					case Mensajes.Reintento_Peticion:
					case Mensajes.Re_Reintento_Peticion:
						{
							// Es Anulación de una Compra o Retiro, aumenta el disponible
							this._ammount1 += this._ammount;
							this._ammount2 += this._ammount;
							this._esdescuento = false;
						}
						break;
				}
				// Estableces Mensaje de Respuesta
			}
			
		}
		
		private void CrearRespuestaConsignacion()
		{
			if (this._err == Errores.Bien)
			{
				// Establecer Saldos
				switch(this._message)
				{
					case Mensajes.Peticion:
					case Mensajes.Reintento_Peticion:
					case Mensajes.Re_Reintento_Peticion:
						{
							// Es una Consignación, aumenta el disponible
							this._ammount1 += this._ammount;
							this._ammount2 += this._ammount;
							this._esdescuento = false;
						}
						break;
				}
			}
			
		}
		
		private void BuscarDatosTarjeta()
		{
			FbDataReader _reader = null;
			FbCommand _query = null;
			
			_query = new FbCommand("SELECT * FROM \"cap$tarjetacuenta\" WHERE \"cap$tarjetacuenta\".ID_TARJETA = @ID_TARJETA",this._conn,this._tran);
			_query.Parameters.Add("@ID_TARJETA",FbDbType.VarChar).Value = this._card.Substring(0,16);
			try
			{
				_reader = _query.ExecuteReader();
				this._err = Errores.Invalida;
				this._ammount1 = 0;
				this._ammount2 = 0;
				if (_reader.Read())
				{
					this._err = Errores.Bien;
					this._estado = _reader.GetInt32(_reader.GetOrdinal("ID_ESTADO"));
					this._idagencia = _reader.GetInt32(_reader.GetOrdinal("ID_AGENCIA"));
					this._tipocuenta = _reader.GetInt32(_reader.GetOrdinal("ID_TIPO_CAPTACION"));
					this._numerocuenta = _reader.GetInt32(_reader.GetOrdinal("NUMERO_CUENTA"));
					this._digitocuenta = _reader.GetInt32(_reader.GetOrdinal("DIGITO_CUENTA"));
					this._cupopos = _reader.GetDecimal(_reader.GetOrdinal("CUPO_POS"));
					this._cupoatm = _reader.GetDecimal(_reader.GetOrdinal("CUPO_ATM"));
				}
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
				BuscarSaldosCuenta();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
			}
			
		}
		
		private void BuscarSaldosCuenta()
		{
			FbDataReader _reader = null;
			FbCommand _query = null;
			
			_query = new FbCommand("SELECT * FROM SALDOTD(@ID_AGENCIA,@ID_TIPO_CAPTACION,@NUMERO_CUENTA,@DIGITO_CUENTA)",this._conn,this._tran);
			_query.Parameters.Add("@ID_AGENCIA",FbDbType.Integer).Value = this._idagencia;
			_query.Parameters.Add("@ID_TIPO_CAPTACION",FbDbType.Integer).Value = this._tipocuenta;
			_query.Parameters.Add("@NUMERO_CUENTA",FbDbType.Integer).Value = this._numerocuenta;
			_query.Parameters.Add("@DIGITO_CUENTA",FbDbType.Integer).Value = this._digitocuenta;
			try
			{
				_reader = _query.ExecuteReader();
				_reader.Read();
				
				if (this._estado == 2)
				{
					this._ammount1 = 0;
					this._ammount2 = 0;
				}
				else
				{
					this._ammount1 = _reader.GetDecimal(_reader.GetOrdinal("SALDO"));
					this._ammount2 = _reader.GetDecimal(_reader.GetOrdinal("DISPONIBLE"));
				}
				
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_reader.Dispose();
				_query.Dispose();
				
			}
			
		}
		
		private bool InsertarMovimientoReintento()
		{
			DateTime _fnow = DateTime.Now;
			int _affectedrow;
			FbCommand _query;
			StringBuilder _cmd = new StringBuilder();
			int _mes = Convert.ToInt32(this._date.Substring(0,2));
			int _dia = Convert.ToInt32(this._date.Substring(2,2));
			int _hora = Convert.ToInt32(this._time.Substring(0,2));
			int _minuto = Convert.ToInt32(this._time.Substring(2,2));
			int _segundo = Convert.ToInt32(this._time.Substring(4,2));
			DateTime _fechahora = new DateTime(_fnow.Year,_mes,_dia,_hora,_minuto,_segundo);
			String _date = String.Format("{0:yyyy-MM-dd}",_fechahora);
			String _time = String.Format("{0:HH:mm:ss}",_fechahora);
			

			_cmd.Append("INSERT INTO \"cap$tarjetamovol\" VALUES (");
			_cmd.Append("@FECHA,");
			_cmd.Append("@HORA,");
			_cmd.Append("@ID_TARJETA,");
			_cmd.Append("@SECUENCIA,");
			_cmd.Append("@MENSAJE,");
			_cmd.Append("@CAUSAL,");
			_cmd.Append("@MONTO");
			_cmd.Append(")");
			_query = new FbCommand(_cmd.ToString(),this._conn,this._tran);
			_query.Parameters.Add("@FECHA",_date);
			_query.Parameters.Add("@HORA",_time);
			_query.Parameters.Add("@ID_TARJETA",this._card.Substring(0,16));
			_query.Parameters.Add("@SECUENCIA",this._secuence);
			_query.Parameters.Add("@MENSAJE",this._message);
			_query.Parameters.Add("@CAUSAL",this._causal);

			if (this._esdescuento)
			{
				_query.Parameters.Add("@MONTO",this._ammount);
			}
			else
			{
				_query.Parameters.Add("@MONTO",-this._ammount);
			}

			try
			{
				_affectedrow = _query.ExecuteNonQuery();
				_query.Dispose();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_query.Dispose();
				
				return false;
			}
			
			return true;
			
			
		}
		
		private bool InsertarMovimientoTarjeta()
		{
			DateTime _fnow = DateTime.Now;
			int _affectedrow;
			FbCommand _query;
			StringBuilder _cmd = new StringBuilder();
			int _mes = Convert.ToInt32(this._date.Substring(0,2));
			int _dia = Convert.ToInt32(this._date.Substring(2,2));
			int _hora = Convert.ToInt32(this._time.Substring(0,2));
			int _minuto = Convert.ToInt32(this._time.Substring(2,2));
			int _segundo = Convert.ToInt32(this._time.Substring(4,2));
			DateTime _fechahora = new DateTime(_fnow.Year,_mes,_dia,_hora,_minuto,_segundo);
			String _date = String.Format("{0:yyyy-MM-dd}",_fechahora);
			String _time = String.Format("{0:HH:mm:ss}",_fechahora);
			
			
			_cmd.Append("INSERT INTO \"cap$tarjetamovsdia\" VALUES (");
			_cmd.Append("@ID_TARJETA,");
			_cmd.Append("@MENSAJE,");
			_cmd.Append("@CAUSAL,");
			_cmd.Append("@SECUENCIA,");
			_cmd.Append("@MONTO,");
			_cmd.Append("@FECHA,");
			_cmd.Append("@HORA,");
			_cmd.Append("@ID_AGENCIA,");
			_cmd.Append("@ID_TIPO_CAPTACION,");
			_cmd.Append("@NUMERO_CUENTA,");
			_cmd.Append("@DIGITO_CUENTA");
			_cmd.Append(")");
			
			_query = new FbCommand(_cmd.ToString(),this._conn,this._tran);
			_query.Parameters.Add("@ID_TARJETA",this._card.Substring(0,16));
			_query.Parameters.Add("@SECUENCIA",this._secuence);
			_query.Parameters.Add("@MENSAJE",this._message);
			_query.Parameters.Add("@CAUSAL",this._causal);
			if (this._esdescuento)
			{
				_query.Parameters.Add("@MONTO",this._ammount);
			}
			else
			{
				_query.Parameters.Add("@MONTO",-this._ammount);
			}
			_query.Parameters.Add("@FECHA",_date);
			_query.Parameters.Add("@HORA",_time);
			_query.Parameters.Add("@ID_AGENCIA",this._idagencia);
			_query.Parameters.Add("@ID_TIPO_CAPTACION",this._tipocuenta);
			_query.Parameters.Add("@NUMERO_CUENTA",this._numerocuenta);
			_query.Parameters.Add("@DIGITO_CUENTA",this._digitocuenta);
			
			try
			{
				_affectedrow = _query.ExecuteNonQuery();
				_query.Dispose();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_query.Dispose();
				
				return false;
			}
			
			return true;
		}
		
		private bool InsertarMovimientoCaja()
		{
			int _idCaja = ValidarCaja();
			if (_idCaja != 0)
			{
				DateTime _fnow = DateTime.Now;
				int _affectedrow;
				int _zero = 0;
				FbCommand _query;
				StringBuilder _cmd = new StringBuilder();
				int _mes = Convert.ToInt32(this._date.Substring(0,2));
				int _dia = Convert.ToInt32(this._date.Substring(2,2));
				int _hora = Convert.ToInt32(this._time.Substring(0,2));
				int _minuto = Convert.ToInt32(this._time.Substring(2,2));
				int _segundo = Convert.ToInt32(this._time.Substring(4,2));
				DateTime _fechahora = new DateTime(_fnow.Year,_mes,_dia,_hora,_minuto,_segundo);
				
				_cmd.Append("INSERT INTO \"caj$movimiento\" (");
				_cmd.Append("ID_CAJA,");
				_cmd.Append("FECHA_MOV,");
				_cmd.Append("ID_AGENCIA,");
				_cmd.Append("ID_TIPO_CAPTACION,");
				_cmd.Append("NUMERO_CUENTA,");
				_cmd.Append("DIGITO_CUENTA,");
				_cmd.Append("ORIGEN_MOVIMIENTO,");
				_cmd.Append("ID_TIPO_MOVIMIENTO,");
				_cmd.Append("DOCUMENTO,");
				_cmd.Append("CHEQUES_MOVIMIENTO,");
				_cmd.Append("BILLETES,");
				_cmd.Append("MONEDAS,");
				_cmd.Append("CHEQUES,");
				_cmd.Append("HUELLA");
				_cmd.Append(") VALUES (");
				_cmd.Append("@ID_CAJA,");
				_cmd.Append("@FECHA_MOV,");
				_cmd.Append("@ID_AGENCIA,");
				_cmd.Append("@ID_TIPO_CAPTACION,");
				_cmd.Append("@NUMERO_CUENTA,");
				_cmd.Append("@DIGITO_CUENTA,");
				_cmd.Append("@ORIGEN_MOVIMIENTO,");
				_cmd.Append("@ID_TIPO_MOVIMIENTO,");
				_cmd.Append("@DOCUMENTO,");
				_cmd.Append("@CHEQUES_MOVIMIENTO,");
				_cmd.Append("@BILLETES,");
				_cmd.Append("@MONEDAS,");
				_cmd.Append("@CHEQUES,");
				_cmd.Append("@HUELLA");
				_cmd.Append(")");
				
				_query = new FbCommand(_cmd.ToString(),this._conn,this._tran);
				_query.Parameters.Add("@ID_CAJA",_idCaja);
				_query.Parameters.Add("@FECHA_MOV",_fechahora);
				_query.Parameters.Add("@ID_AGENCIA",this._idagencia);
				_query.Parameters.Add("@ID_TIPO_CAPTACION",this._tipocuenta);
				_query.Parameters.Add("@NUMERO_CUENTA",this._numerocuenta);
				_query.Parameters.Add("@DIGITO_CUENTA",this._digitocuenta);
				_query.Parameters.Add("@ORIGEN_MOVIMIENTO",10);
				if (this._esdescuento)
				{
					_query.Parameters.Add("@ID_TIPO_MOVIMIENTO",2);
				}
				else
				{
					_query.Parameters.Add("@ID_TIPO_MOVIMIENTO",1);
				}
				_query.Parameters.Add("@DOCUMENTO",this._secuence.Substring(8,4));
				_query.Parameters.Add("@CHEQUES_MOVIMIENTO",_zero);
				_query.Parameters.Add("@BILLETES",this._ammount);
				_query.Parameters.Add("@MONEDAS",_zero);
				_query.Parameters.Add("@CHEQUES",_zero);
				_query.Parameters.Add("@HUELLA",_zero);
				try
				{
					_affectedrow = _query.ExecuteNonQuery();
					_query.Dispose();
				}
				catch (FbException e)
				{
					ColocarError(e);
					_query.Dispose();
					
					return false;
				}
				
				return true;
				
			}
			
			return true;
		}
		
		private int ValidarCaja()
		{
			FbCommand _query = null;
			FbDataReader _reader = null;
			int _caja = 0;

			_query = new FbCommand("SELECT ID_CAJA FROM \"caj$cajas\" WHERE DATAFONO = @DATAFONO",this._conn,this._tran);
			_query.Parameters.Add("@DATAFONO",FbDbType.VarChar,8).Value = this._datafono;

			try
			{
				_reader = _query.ExecuteReader();
				if (_reader.Read())
				{
					_caja = _reader.GetInt32(_reader.GetOrdinal("ID_CAJA"));
				}
			}
			catch (FbException e)
			{
				FbErrorCollection myErrors = e.Errors;
				
				Console.WriteLine("Error : {0}.", e.Message);
				Console.WriteLine("Error reported by {0}", e.Source);
				Console.WriteLine("Neither record was written to database.");
				Console.WriteLine("Errors collection contains:");

				for (int i=0; i < myErrors.Count; i++)
				{
					Console.WriteLine("Class: {0}", myErrors[i].Class);
					Console.WriteLine("Error #{1}: {2} on line {3}.", myErrors[i].Number, myErrors[i].Message, myErrors[i].LineNumber);
				}
				
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
				
				return _caja;
			}
			
			return _caja;
		}
		
		private void EstablecerMensajeRespuesta()
		{
			switch(_message)
			{
				case Mensajes.Reverso:
				case Mensajes.R_Reverso:
					this._msg = Mensajes.Respuesta_Reverso;
					break;
				case Mensajes.Peticion:
					this._msg = Mensajes.Respuesta_Peticion;
					break;
				case Mensajes.Reintento_Peticion:
				case Mensajes.Re_Reintento_Peticion:
					this._msg = Mensajes.Respuesta_Reintento;
					break;
			}
		}
		
		private void ColocarError(FbException e)
		{
			FbErrorCollection myErrors = e.Errors;
			
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Error : " + e.Message);
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Error reported by " + e.Source);
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Neither record was written to database.");
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Errors collection contains:");

			for (int i=0; i < myErrors.Count; i++)
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Class: " + Convert.ToString(myErrors[i].Class));
				CreateLogFiles.ErrorLog(globalvars.Logfile,String.Format("Error #{0}: {1} on line {2}.", myErrors[i].Number, myErrors[i].Message, myErrors[i].LineNumber));
			}
		}
	}
}
