/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/15
 * Hora: 02:23 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Xml;
using System.Data;
using System.Text;
using FirebirdSql.Data.FirebirdClient;


namespace servertarjetadebito
{
	/// <summary>
	/// Description of tdmanager.
	/// </summary>
	public class Tdmanager
	{
		private byte[] _databytes;
		private byte[] _returnbytes;
		private int _returnPort;
		private string _xmlstring;

		public int Returnport {
			get { return _returnPort; }
		}
		
		public byte[] Returnbytes {
			get { return _returnbytes; }
			set { _returnbytes = value; }
		}
		
		public byte[] Databytes {
			get { return _databytes; }
			set { _databytes = value; }
		}
		
		public Tdmanager()
		{
		}
		
		public void Execute()
		{
			char[] szHead  = new char[3];
			int b_nSize;
			int b_nCrc;
			byte[] vbKey   = new byte[8];
			byte[] data    = new byte[1024];
			int discarded = 0;
			// Convertir byte[] to stream
			MemoryStream mstream = new MemoryStream(this._databytes);
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
			
			_xmlstring = HexEncoding.HexToString(hexresult);
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Petición:"+_xmlstring);
			
			XmlParse();
			
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Respuesta:"+Encoding.ASCII.GetString(this._returnbytes));

			
			hexdata = HexEncoding.ToString(this._returnbytes);
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
			this._returnbytes = rd.ReadBytes((int)ms.Length);
			rd.Close();
			wr.Close();

		}
		
		private void XmlParse()
		{
			
			XmlDocument _xmldoc = new XmlDocument();
			XmlDocument _xmlret = new XmlDocument();
			XmlDocument _xmlofc = new XmlDocument();

			
			_xmldoc.LoadXml(_xmlstring);

			XmlNodeList _xmlnodelist = _xmldoc.GetElementsByTagName("ROW");
			XmlElement _xmlnode = (XmlElement)_xmlnodelist[0];
			if (_xmlnode != null)
			{
				_returnPort = Convert.ToInt32(_xmlnode.GetAttribute("PORT"));
				string _card = _xmlnode.GetAttribute("CARD");
				
				
				XmlElement _xmlnodetemp = _xmlofc.CreateElement("","DATA","");
				_xmlnodetemp.SetAttribute("PORT",_xmlnode.GetAttribute("PORT"));
				_xmlnodetemp.SetAttribute("ID",_xmlnode.GetAttribute("ID"));
				_xmlnodetemp.SetAttribute("DATE",_xmlnode.GetAttribute("DATE"));
				_xmlnodetemp.SetAttribute("TIME",_xmlnode.GetAttribute("TIME"));
				_xmlnodetemp.SetAttribute("SECUENCE",_xmlnode.GetAttribute("SECUENCE"));
				_xmlnodetemp.SetAttribute("MESSAGE",_xmlnode.GetAttribute("MESSAGE"));
				_xmlnodetemp.SetAttribute("CAUSAL",_xmlnode.GetAttribute("CAUSAL"));
				_xmlnodetemp.SetAttribute("CARD",_xmlnode.GetAttribute("CARD"));
				_xmlnodetemp.SetAttribute("NET",_xmlnode.GetAttribute("NET"));
				_xmlnodetemp.SetAttribute("AMMOUNT",_xmlnode.GetAttribute("AMMOUNT"));
				_xmlnodetemp.SetAttribute("CUEN",_xmlnode.GetAttribute("CUEN"));
				
				_xmlofc.AppendChild(_xmlnodetemp);
				
				string _sOfcData = _xmlofc.OuterXml;
				string _sOfcRetData = "";
				
				globalvars._sAgencia _vCard = ValidarCard(_card);
				switch (_vCard._agencia)
				{
						case 0: break;
						default:{
						 		_sOfcRetData = UDPTransfer(_sOfcData, _vCard._host, _vCard._port, _returnPort);
								break;
						}
				}
				
				StringBuilder _str = new StringBuilder();
				_str.Append("<TRANSA><HEADER><SOURCE>0.0.0.0</SOURCE></HEADER><FIELDS></FIELDS><DATA>");
				_str.Append(_sOfcRetData);
				_str.Append("</DATA></TRANSA>");
				
				this._returnbytes = Encoding.ASCII.GetBytes(_str.ToString());
			}
		}
		
		private globalvars._sAgencia ValidarCard(string _card)
		{
			string ConnectionString;
			FbConnectionStringBuilder cs = new FbConnectionStringBuilder ();
			FbDataReader _reader = null;
			FbCommand _query = null;
			cs.DataSource = globalvars.server;
			cs.Database = globalvars.database;
			cs.UserID = globalvars.user;
			cs.Password = globalvars.password;
			cs.Role = globalvars.role;
			cs.Dialect = 3;
			cs.Charset = "ISO8859_1";
			globalvars._sAgencia _vAgencia;
			
			ConnectionString = cs.ToString ();
			FbConnection _conn = new FbConnection (ConnectionString);
			_conn.Open ();
			FbTransaction _transaction = _conn.BeginTransaction ();
			_query = new FbCommand("SELECT TDB$ASIGNADA.ID_AGENCIA, GEN$SERVIDOR.ID_HOST, GEN$SERVIDOR.ID_PUERTO FROM TDB$TARJETA " +
			                       "INNER JOIN TDB$ASIGNADA ON (TDB$TARJETA.ID_TARJETA = TDB$ASIGNADA.ID_TARJETA) " +
			                       "INNER JOIN GEN$SERVIDOR ON (TDB$ASIGNADA.ID_AGENCIA = GEN$SERVIDOR.ID_AGENCIA) " +
			                       "WHERE TDB$TARJETA.ID_TARJETA = '" + _card + "' AND GEN$SERVIDOR.ID_SERVICIO = 3",_conn,_transaction);
/*			FbParameter param = new FbParameter("@ID_TARJETA",FbDbType.Char,16);
			param.Value = _card;
			param.Direction = ParameterDirection.Input;
			_query.Parameters.Add(param);
*/
			try
			{
				_query.Prepare();
				_reader = _query.ExecuteReader();
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
				_vAgencia._agencia = 0;
				_vAgencia._host = "";
				_vAgencia._port = 0;
				return _vAgencia ;
			}			
			
			_vAgencia._agencia = 0;
			_vAgencia._host = "";
			_vAgencia._port = 0;
			
			while (_reader.Read())
			{
				_vAgencia._agencia = _reader.GetInt32(0);
				_vAgencia._host = _reader.GetString(1);
				_vAgencia._port = _reader.GetInt32(2);
				_reader.NextResult();
			}
			
			_transaction.Commit();
			_reader.Dispose();
			_transaction.Dispose();
			_conn.Close();
			_conn.Dispose();
			
			return _vAgencia;
			
			
		}
		
		private string UDPTransfer(string _sOfcString, string _host, int _port, int _rPort)
		{
			string _sReturn = "";
			byte[] data = new byte[1024];
			UdpClient udpCliente = new UdpClient(_host,_port);
			
			IPEndPoint ip = new IPEndPoint(IPAddress.Parse(_host), _port);
			data = Encoding.ASCII.GetBytes(_sOfcString);
			udpCliente.Send(data,data.Length);
			data = new byte[1024];
			data = udpCliente.Receive(ref ip);
			_sReturn = Encoding.ASCII.GetString(data);
			
			return _sReturn;
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
