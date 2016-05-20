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
using System.IO;
using System.Security.Cryptography;
using FirebirdSql.Data.FirebirdClient;

namespace serverTD
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
		private int _oficinadatafono;
		
		// Dato que me define si el valor a aplicar es un descuento o
		// un incremento
		private bool _esdescuento;  // este valor representa un ingreso de un valor positivo
		private bool _aplicar; // este valor indica si la operación debe registrarse o no en la tabla de movimientos
		private bool _esdatafono; // es una operacion por datafono o no.
		
		// Datos de uso interno
		private int _estado;
		
		// Datos Respuesta
		private Mensajes _msg;
		private Errores  _err;
		private decimal _ammount1;
		private decimal _ammount2;
		//
		private bool _actualizarlocal;
		
		public bool Actualizarlocal {
			get { return _actualizarlocal; }
			set { _actualizarlocal = value; }
		}
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
			char[] szHead  = new char[3];
			int b_nSize;
			int b_nCrc;
			byte[] vbKey   = new byte[8];
			byte[] data    = new byte[1024];
			int discarded = 0;
			// Convertir byte[] to stream
			MemoryStream mstream = new MemoryStream(_data);
			BinaryReader br = new BinaryReader(mstream);
			// Leer szHead, valor esperado 'XML'
			szHead = br.ReadChars(3);
			b_nSize = br.ReadInt32();
			b_nCrc = br.ReadInt32();
			vbKey = br.ReadBytes(8);
			data = br.ReadBytes(b_nSize);
			
			string hexdata = HexEncoding.ToString(vbKey);
			string key = globalvars.Constkey;
			string hexresult = DESDecrypt(hexdata,key);

			hexdata = HexEncoding.ToString(data);
			key = hexresult;
			hexresult = DESDecrypt(hexdata,key);
			
			string _xmlstring = HexEncoding.HexToString(hexresult);
			CreateLogFiles.ErrorLog(globalvars.Logfile,_xmlstring);
			
			XmlDocument _xmldoc = new XmlDocument();
			Encoding en = Encoding.ASCII;
			FbConnectionStringBuilder _cs = new FbConnectionStringBuilder();
			// Cargar el string con el xml embebido
			_xmldoc.LoadXml(_xmlstring);
			XmlNodeList _xmlnodelist = _xmldoc.GetElementsByTagName("ROW");
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
			
			StringBuilder _strmessage = new StringBuilder();
			_strmessage.AppendFormat("Petición:\n\tTarjeta:{0}\n",this._card);
			_strmessage.AppendFormat("\tFecha:{0}\n",this._date);
			_strmessage.AppendFormat("\tHora:{0}\n",this._time);
			_strmessage.AppendFormat("\tMensaje:{0}\n",this._message.ToString("g"));
			_strmessage.AppendFormat("\tCausal:{0}\n",this._causal.ToString("g"));
			_strmessage.AppendFormat("\tSecuencia:{0}\n",this._secuence);
			_strmessage.AppendFormat("\tMonto:{0}",this._ammount);
			CreateLogFiles.ErrorLog(globalvars.Logfile,_strmessage.ToString());
			_strmessage = null;
			
			
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
				this._actualizarlocal = true;
			}
			else
			{
				this._tran.Rollback();
				this._actualizarlocal = false;
			}
			
			if (this._aplicar && this._actualizarlocal){
				this._actualizarlocal = true;
			}
			else{
				this._actualizarlocal = false;
			}
			
			this._tran.Dispose();
			this._conn.Close();
			this._conn.Dispose();
			
			hexdata = HexEncoding.ToString(this._returndata);
			hexresult = DESEncrypt(hexdata,key);
			data = HexEncoding.GetBytes(hexresult,out discarded);

			MemoryStream ms = new MemoryStream();
			BinaryWriter wr = new BinaryWriter(ms);
			b_nSize = data.Length;
			wr.Write(szHead);
			wr.Write(b_nSize);
			wr.Write(b_nCrc);
			wr.Write(vbKey);
			wr.Write(data);
			wr.Seek(0, SeekOrigin.Begin);
			BinaryReader rd = new BinaryReader(ms);
			this._returndata = rd.ReadBytes((int)ms.Length);
			rd.Close();
			wr.Close();
			
		}
		
		private void Execute()
		{
			this._esdatafono = false;
			BuscarDatosTarjeta();
			
			if (this._net == "5"){
				this._esdatafono = true;
				BuscarDatosDatafono();
			}
				
			
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
				case Causal.Invalida:
					{
						this._ammount1 = 0;
						this._ammount2 = 0;
						this._err = Errores.Invalida;
					}
					break;
					default: break;
			}
			
			EstablecerMensajeRespuesta();
			
			if (this._err == Errores.Bien)
			{
				switch(this._message)
				{
					case Mensajes.Reintento_Peticion:
					case Mensajes.Re_Reintento_Peticion:
					case Mensajes.R_Reverso:
						InsertarMovimientoReintento(); // propenso a fallo
						CreateLogFiles.ErrorLog(globalvars.Logfile,"Insertado en TDB$REINTENTO bien!");
						break;
						default: break;
				}
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
								ActualizarSaldoTarjeta();
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

			StringBuilder _strmessage = new StringBuilder();
			_strmessage.AppendFormat("Respuesta:\n\tTarjeta:{0}\n",this._card);
			_strmessage.AppendFormat("\tMensaje:{0}\n",this._msg.ToString("g"));
			_strmessage.AppendFormat("\tError:{0}\n",this._err.ToString("g"));
			_strmessage.AppendFormat("\tSecuencia:{0}\n",this._secuence);
			_strmessage.AppendFormat("\tSaldo:{0}\n",this._ammount1);
			_strmessage.AppendFormat("\tDisponible:{0}",this._ammount2);
			
			CreateLogFiles.ErrorLog(globalvars.Logfile,_strmessage.ToString());
			_strmessage = null;
			
			StringBuilder _str = new StringBuilder();
			string _sOfcRetData = _xmlnodetemp.OuterXml;
			_str.Append("<TRANSA><HEADER><SOURCE>0.0.0.0</SOURCE></HEADER><FIELDS></FIELDS><DATA>");
			_str.Append(_sOfcRetData);
			_str.Append("</DATA></TRANSA>");
			
//			this._returndata =  Encoding.ASCII.GetBytes(_xmlnodetemp.OuterXml);
			this._returndata = Encoding.ASCII.GetBytes(_str.ToString());
		}
		
		private bool RevisoOperacion()
		{
			DateTime _fnow = DateTime.Now;
			FbDataReader _reader = null;
			bool _retorno;
			int _total;
			FbCommand _query;
			StringBuilder _cmd = new StringBuilder();
			int _mes = Convert.ToInt32(this._date.Substring(0,2));
			int _dia = Convert.ToInt32(this._date.Substring(2,2));
			int _hora = Convert.ToInt32(this._time.Substring(0,2));
			int _minuto = Convert.ToInt32(this._time.Substring(2,2));
			int _segundo = Convert.ToInt32(this._time.Substring(4,2));
			DateTime _fechahora = new DateTime(_fnow.Year,_mes,_dia,_hora,_minuto,_segundo);
			
			_cmd.Append("SELECT COUNT(*) AS TOTAL FROM TDB$TARJETAMOVSDIA WHERE ");
			_cmd.Append("ID_TARJETA = @ID_TARJETA AND ");
//			_cmd.Append("MENSAJE = @MENSAJE AND ");
			_cmd.Append("CAUSAL = @CAUSAL AND ");
			_cmd.Append("SECUENCIA = @SECUENCIA AND ");
			_cmd.Append("ABS(MONTO) = ABS(@MONTO) AND ");
			_cmd.Append("FECHA = @FECHA AND ");
			_cmd.Append("HORA = @HORA");
			
			_query = new FbCommand(_cmd.ToString(),this._conn,this._tran);
			_query.Parameters.Add("@ID_TARJETA",this._card.Substring(0,16));
//			_query.Parameters.Add("@MENSAJE",((int)this._message));
			_query.Parameters.Add("@CAUSAL",((int)this._causal));
			_query.Parameters.Add("@SECUENCIA",this._secuence);
			_query.Parameters.Add("@MONTO",this._ammount);
			/*			if (this._esdescuento)
			{
				_query.Parameters.Add("@MONTO",-this._ammount);
			}
			else
			{
				_query.Parameters.Add("@MONTO",this._ammount);
			}
			 */
			_query.Parameters.Add("@FECHA",_fechahora.Date.ToString());
			_query.Parameters.Add("@HORA",_fechahora.TimeOfDay.ToString());
			
			try
			{
				_reader = _query.ExecuteReader();
				if (_reader.Read())
				{
					_total = _reader.GetInt32(_reader.GetOrdinal("TOTAL"));
					if (_total == 1) {
						_retorno = true;
					}
					else
					{
						_retorno = false;
					}
					
				}
				else
				{
					_retorno = false;
				}
			}
			catch (FbException e)
			{
				ColocarError(e);
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
				_retorno = false;
			}
			
			_reader.Close();
			_reader.Dispose();
			_query.Dispose();
			if (_retorno == false){
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Error : " + "No se encontro operacion Original");
			}
			else
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Error : " + "Se encontro operacion Original aplicando reverso...");
			}
			
			return _retorno;
		}
		
		private void CrearRespuestaConsulta()
		{
			
			this._aplicar = true;
			if (this._err == Errores.Bien)
			{
				// Establecer Saldos
				switch(this._message)
				{
					case Mensajes.Reverso:
						{
							// Es Reverso de una Compra o Retiro, aumenta el disponible
							if (RevisoOperacion()){
								this._ammount1 += this._ammount;
								this._ammount2 += this._ammount;
								this._esdescuento = false;
								this._aplicar = true;
							}
							else
							{
								this._ammount = 0;
								this._esdescuento = false;
								this._aplicar = false;
							}
						}
						break;
					case Mensajes.R_Reverso:
						{
							//<TODO> Validar si ya existe un reverso equivalente y
							// responder con los mismos saldos sin aplicar la reversión
							//</TODO>
							// Es Reverso de una Compra o Retiro, aumenta el disponible
							if (RevisoOperacion()){
								this._ammount1 += this._ammount;
								this._ammount2 += this._ammount;
								this._esdescuento = false;
								this._aplicar = true;
							}
							else
							{
								this._ammount = 0;
								this._esdescuento = false;
								this._aplicar = false;
							}
						}
						break;
					case Mensajes.Peticion:
						{
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
			this._aplicar = true;
			if (this._err == Errores.Bien)
			{
				// Establecer Saldos
				// Buscar Primera operación antes de afectar los saldos.
				switch(this._message)
				{
					case Mensajes.Reverso:
					case Mensajes.R_Reverso:
						{
							// Es Reverso de una Anulación de una Compra o Retiro, disminuye el disponible
							// Pero primero verifico si existe la operación original
							if (RevisoOperacion()){
								this._ammount1 -= this._ammount;
								this._ammount2 -= this._ammount;
								this._esdescuento = true;
								this._aplicar = true;
							}
							else
							{
								this._ammount = 0;
								this._esdescuento = true;
								this._aplicar = false;
							}
						}
						break;
					case Mensajes.Peticion:
					case Mensajes.Reintento_Peticion:
					case Mensajes.Re_Reintento_Peticion:
						{
							// Es Anulación de una Compra o Retiro, aumenta el disponible
							if (RevisoOperacion()){
								this._ammount1 += this._ammount;
								this._ammount2 += this._ammount;
								this._esdescuento = false;
								this._aplicar = true;
							}
							else
							{
								this._ammount = 0;
								this._esdescuento = true;
								this._aplicar = false;
							}
						}
						break;
				}
				// Estableces Mensaje de Respuesta
			}
			
		}
		
		private void CrearRespuestaConsignacion()
		{
			this._aplicar = true;
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
			StringBuilder _qstr = new StringBuilder();
			_qstr.Append("SELECT ");
			_qstr.Append("TDB$TARJETA.ID_ESTADO,");
			_qstr.Append("TDB$SALDO.SALDODISPONIBLE,");
			_qstr.Append("TDB$SALDO.SALDOTOTAL ");
			_qstr.Append("FROM ");
			_qstr.Append("TDB$TARJETA ");
			_qstr.Append("INNER JOIN TDB$SALDO ON (TDB$TARJETA.ID_TARJETA = TDB$SALDO.TARJETA) ");
			_qstr.Append("WHERE ");
			_qstr.Append("(TDB$TARJETA.ID_TARJETA = @ID_TARJETA)");
			
			
			_query = new FbCommand(_qstr.ToString(),this._conn,this._tran);
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
					if (this._estado == 2)
					{
						this._ammount1 = 0;
						this._ammount2 = 0;
					}
					else
					{
						this._ammount1 = _reader.GetDecimal(_reader.GetOrdinal("SALDOTOTAL"));
						this._ammount2 = _reader.GetDecimal(_reader.GetOrdinal("SALDODISPONIBLE"));
					}
				}
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
			}
			
		}
		
		private void BuscarDatosDatafono()
		{
			FbDataReader _reader = null;
			FbCommand _query = null;
			StringBuilder _qstr = new StringBuilder();
			_qstr.Append("SELECT ");
			_qstr.Append("d.DATA_OFICINA,");
			_qstr.Append("FROM ");
			_qstr.Append("TDB$DATAFONO d ");
			_qstr.Append("WHERE ");
			_qstr.Append("d.DATA_CODIGO = @DATA_CODIGO)");
			
			
			_query = new FbCommand(_qstr.ToString(),this._conn,this._tran);
			_query.Parameters.Add("@DATA_CODIGO",FbDbType.VarChar).Value = this._secuence.Substring(2,6);
			try
			{
				_reader = _query.ExecuteReader();
				if (_reader.Read())
				{
					this._oficinadatafono = _reader.GetInt32(_reader.GetOrdinal("DATA_OFICINA"));
				}
				_reader.Close();
				_reader.Dispose();
				_query.Dispose();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_reader.Close();
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
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Fecha:Hora: "+_date+":"+_time);
			
			_cmd.Append("INSERT INTO TDB$REINTENTO VALUES (");
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
			CreateLogFiles.ErrorLog(globalvars.Logfile,_query.ToString());

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
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Insertando en TDB$REINTENTO");
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
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Fecha:Hora: "+_date+":"+_time);

			
			_cmd.Append("INSERT INTO TDB$TARJETAMOVSDIA VALUES (");
			_cmd.Append("@ID_TARJETA,");
			_cmd.Append("@MENSAJE,");
			_cmd.Append("@CAUSAL,");
			_cmd.Append("@SECUENCIA,");
			_cmd.Append("@MONTO,");
			_cmd.Append("@FECHA,");
			_cmd.Append("@HORA");
			_cmd.Append(")");
			
			_query = new FbCommand(_cmd.ToString(),this._conn,this._tran);
			_query.Parameters.Add("@ID_TARJETA",this._card.Substring(0,16));
			_query.Parameters.Add("@MENSAJE",((int)this._message));
			_query.Parameters.Add("@CAUSAL",((int)this._causal));
			_query.Parameters.Add("@SECUENCIA",this._secuence);
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
			
			if (this._aplicar) {
				try
				{
					CreateLogFiles.ErrorLog(globalvars.Logfile,"Insertando en TDB$TARJETAMOVSDIA");
					_affectedrow = _query.ExecuteNonQuery();
					_query.Dispose();
				}
				catch (FbException e)
				{
					ColocarError(e);
					_query.Dispose();
					
					return false;
				}
			}
			
			return true;
		}
		
		private void ActualizarSaldoTarjeta()
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
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Fecha:Hora: "+_date+":"+_time);

			_cmd.Append("UPDATE TDB$SALDO SET ");
			_cmd.Append("FECHA = @FECHA, HORA = @HORA,");
			_cmd.Append("SALDODISPONIBLE = @DISPONIBLE,");
			_cmd.Append("SALDOTOTAL = @SALDO ");
			_cmd.Append("WHERE TDB$SALDO.TARJETA = @ID_TARJETA");
			
			_query = new FbCommand(_cmd.ToString(),this._conn,this._tran);
			_query.Parameters.Add("@ID_TARJETA",this._card.Substring(0,16));
			_query.Parameters.Add("@FECHA",_date);
			_query.Parameters.Add("@HORA",_time);
			_query.Parameters.Add("@SALDO",this._ammount1);
			_query.Parameters.Add("@DISPONIBLE",this._ammount2);
			
			try
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Actualizando en TDB$SALDO");
				_affectedrow = _query.ExecuteNonQuery();
				_query.Dispose();
			}
			catch (FbException e)
			{
				ColocarError(e);
				_query.Dispose();
				
			}
			
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
		
		private static string DESEncrypt(string message, string key)
		{
			int discarded;
			
			DESCryptoServiceProvider des = new DESCryptoServiceProvider();
			
			des.Key = HexEncoding.GetBytes(key,out discarded);

			des.Mode = CipherMode.ECB;
			
			des.Padding = PaddingMode.Zeros;

			ICryptoTransform encryptor = des.CreateEncryptor();
			
			byte[] data = HexEncoding.GetBytes(message, out discarded);

			byte[] dataEncrypted = encryptor.TransformFinalBlock(data, 0, data.Length);

			return HexEncoding.ToString(dataEncrypted);
		}

		private static string DESDecrypt(string message, string key)
		{
			int discarded;
			
			DESCryptoServiceProvider des = new DESCryptoServiceProvider();
			
			des.Key = HexEncoding.GetBytes(key,out discarded);
			
			des.Mode = CipherMode.ECB;
			
			des.Padding = PaddingMode.Zeros;
			
			ICryptoTransform decryptor = des.CreateDecryptor();
			
			byte[] data = HexEncoding.GetBytes(message, out discarded);

			byte[] dataDecrypted = decryptor.TransformFinalBlock(data, 0, data.Length);

			return HexEncoding.ToString(dataDecrypted);
		}
		
	}
}
