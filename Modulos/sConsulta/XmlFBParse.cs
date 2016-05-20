/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/10/04
 * Hora: 02:06 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.Text;
using System.Xml;
using System.Data;
using FirebirdSql.Data.FirebirdClient;

namespace sConsulta
{
	/// <summary>
	/// Description of XmlFBParse.
	/// </summary>
	public class XmlFBParse
	{
			private string _receivestr = "";
			private string  _returnstr = "";
			private string _remoteip;
			private Encoding _mEncoding;
			
			XmlDocument _xmldoc = new XmlDocument ();
			XmlDocument _xmldocret = new XmlDocument ();
			XmlElement _root;
			
			public string Receivestr {
				get { return _receivestr; }
				set { _receivestr = value; }
			}
			
			public Encoding MEncoding {
				get { return _mEncoding; }
				set { _mEncoding = value; }
			}

			public XmlFBParse(string RemoteIP)
			{
//				System.Console.WriteLine("Creando QueryReturn...");
				_remoteip = RemoteIP;
			}
			
			public void ExecuteQuery()
			{
				
				CreateLogFiles Err = new CreateLogFiles();
//				System.Console.WriteLine("Iniciando Ejecucin de QueryReturn...");
				
				_root = _xmldocret.CreateElement("","Retorno","");
				
				_xmldocret.AppendChild(_root);

//				System.Console.WriteLine("Cargando Xml...");
				
				try
				{
					_xmldoc.LoadXml (_receivestr);
				}
				catch (XmlException e)
				{
					Err.ErrorLog(globalvars.Logfile,_remoteip+":Error Cargando Xml..."+e.Message+"\n\r"+_receivestr);
				}
				
				/*
			XmlTextWriter writer = new XmlTextWriter(Console.Out);
			writer.Formatting = Formatting.Indented;
			_xmldoc.WriteContentTo (writer);
			writer.Flush();
			Console.WriteLine();
				 */
				XmlNodeList Anode = _xmldoc.GetElementsByTagName("query");
				
//				System.Console.WriteLine("Elementos querys\r\n"+Anode[0].InnerXml);
				int i = 0;
				
				foreach (XmlElement _nodo in Anode)
				{
					try
					{
						string tipo = _nodo["tipo"].InnerText;
						string sentencia = _nodo["sentencia"].InnerText;
						
//					System.Console.WriteLine("Tipo\t\tConsulta[{0:00}]:"+tipo,i);
//				    System.Console.WriteLine("Sentencia\t\tConsulta[{0:00}]:"+sentencia,i);
						Err.ErrorLog(globalvars.Logfile,_remoteip+":ejecutando sentencia:"+sentencia);
						switch (ValidarTipo(tipo))
						{
								case 0: 	fSelect(i, sentencia);
								break;
								case 1: 	fInsert(i, sentencia);
								break;
								case 2:		fDelete(i, sentencia);
								break;
								case 3:		fUpdate(i, sentencia);
								break;
								default:	fExecute(i, sentencia);
								break;
						}
					}
					catch (XmlException e)
					{
						Err.ErrorLog(globalvars.Logfile,_remoteip+":"+e.Message);
					}
					
					i++;
				}
				
				_returnstr = _xmldocret.OuterXml;
//				System.Console.WriteLine("Xml Retorno Generado...");
//				System.Console.WriteLine(_returnstr);
			}
			
			internal void fSelect(int i, string sentencia)
			{
				int k;
				int j = 0;
				string ConnectionString;
				FbConnectionStringBuilder cs = new FbConnectionStringBuilder ();
				string _xmlelementstr = String.Format("{0}{1:000}","consulta",i);
				FbDataReader _reader = null;
				FbCommand _query = null;
				
				DataTable dt;
				
//				System.Console.WriteLine("Ejecutando Consulta Select, xmlelementstr:"+_xmlelementstr);
				
				XmlElement _consulta = _xmldocret.CreateElement("",_xmlelementstr,"");
				
//				System.Console.WriteLine("Elemento consulta, creado...");

				cs.DataSource = globalvars.server;
				cs.Database = globalvars.database;
				cs.UserID = globalvars.user;
				cs.Password = globalvars.password;
				cs.Role = globalvars.role;
				cs.Dialect = 3;
				cs.Charset = "ISO8859_1";
				
				ConnectionString = cs.ToString ();
				
//				System.Console.WriteLine("Cadena de Conexin:["+ConnectionString+"]");
				
				FbConnection _conn = new FbConnection (ConnectionString);
				
//				System.Console.WriteLine("Conexin DB Creada...");
				
//				System.Console.WriteLine("Conectando a la base de datos...");
				_conn.Open ();
				
				FbTransaction _transaction = _conn.BeginTransaction ();
				
//				System.Console.WriteLine("Transaction Iniciada...");
				try
				{
				
					_query = new FbCommand(sentencia, _conn, _transaction);
					_reader = _query.ExecuteReader ();
					dt = _reader.GetSchemaTable();
					_consulta.SetAttribute("campos",Convert.ToString(_reader.FieldCount));
					k = 1;
				
					foreach (DataRow myField in dt.Rows){
						//Para cada propiedad del campo...
						//    			foreach (DataColumn myProperty in dt.Columns) {
						//Mostrar el nombre y el valor del campo.
	//				Console.WriteLine(myProperty.ColumnName + " = " + myField[myProperty].ToString());
						_consulta.SetAttribute(String.Format("camponombre{0}",k),myField[0].ToString());
						_consulta.SetAttribute(String.Format("campotamano{0}",k),myField[2].ToString());
	//				_consulta.SetAttribute(String.Format("campotipo{0}",i),myField[5].ToString());
						k++;
						//}
						//    		Console.WriteLine();
					}
				
			
					try
					{
						while (_reader.Read())
						{

							XmlElement _registro = _xmldocret.CreateElement("","Registro","");

							for ( j=0;j<(_reader.FieldCount); j++ )
							{
								_consulta.SetAttribute(String.Format("campotipo{0}",j+1),_reader.GetDataTypeName(j));
	//						_consulta.SetAttribute(String.Format("camponombre{0}",j+1),_reader.GetName(j));
	//						_consulta.SetAttribute(String.Format("campotamano{0}",j+1),"0");
							
								XmlElement _campo = _xmldocret.CreateElement("","campo","");
								string tipocampo = _reader.GetDataTypeName(j);
							
								if (tipocampo == "BLOB")
								{
									if (_reader.IsDBNull(j)){
									    	_campo.InnerText = "";
									    }
									else
									{
										long rsize = _reader.GetBytes(j,0,null,0,0);
										byte[] rbuffer = new byte[rsize];
										_reader.GetBytes(j,0,rbuffer,0,(int)rsize);
										_campo.InnerText = Convert.ToBase64String(rbuffer);
									}
								}
								else if (tipocampo == "DATE")
								{
									if (_reader.IsDBNull(j)){
									    	_campo.InnerText = "";
									    }
									else
									{
										DateTime date = _reader.GetDateTime(j);
										_campo.InnerText = date.ToString("yyyy/MM/dd");
									}
								}
								else if (tipocampo == "TIME")
								{
									if (_reader.IsDBNull(j)){
									    	_campo.InnerText = "";
									    }
									else
									{
										DateTime date = _reader.GetDateTime(j);
										_campo.InnerText = date.ToString("HH:mm:ss");
									}
								}
								else if (tipocampo == "TIMESTAMP")
								{
									if (_reader.IsDBNull(j)){
									    	_campo.InnerText = "";
									    }
									else
									{
										DateTime date = _reader.GetDateTime(j);
										_campo.InnerText = date.ToString("yyyy/MM/dd HH:mm:ss");
									}
								}
								else
								{
									_campo.InnerText = _reader.GetString(j);
								}
								
								_registro.AppendChild(_campo);
							}
							_consulta.AppendChild(_registro);
							_reader.NextResult();
						}
						_root.AppendChild(_consulta);
					}
					finally
					{
						_reader.Close ();
					 	_transaction.Rollback();
						_query.Dispose();
						_conn.Close();
					}
				}
				catch (FbException e)
				{
					_consulta.SetAttribute("campos","1");
					_consulta.SetAttribute("campotipo1","VARCHAR");
					_consulta.SetAttribute("camponombre1","ERROR EN EL QUERY");
					_consulta.SetAttribute("campotamano1","200");
					XmlElement _registro = _xmldocret.CreateElement("","Registro","");
					XmlElement _campo = _xmldocret.CreateElement("","campo","");
					_campo.InnerText = e.Message;
					_registro.AppendChild(_campo);
					_consulta.AppendChild(_registro);
					_root.AppendChild(_consulta);
					try{
						_reader.Close ();
					}
					catch
					{
						 try
						 {
						 	_transaction.Rollback();
						 }
						 catch
					 	 { 
						 	try
						 	{
							_query.Dispose();
						 	}
						 	catch
					 		{
								_conn.Close();
							}
						 }
					}
				}

			}

			internal void fInsert(int i, string sentencia)
			{
				string ConnectionString;
				FbConnectionStringBuilder cs = new FbConnectionStringBuilder ();
				string _xmlelementstr = String.Format("{0}{1:000}","consulta",i);
				
//				System.Console.WriteLine("Ejecutando Consulta Insert, xmlelementstr:"+_xmlelementstr);
				
				XmlElement _consulta = _xmldocret.CreateElement("",_xmlelementstr,"");
				
//				System.Console.WriteLine("Elemento consulta, creado...");

				cs.DataSource = globalvars.server;
				cs.Database = globalvars.database;
				cs.UserID = globalvars.user;
				cs.Password = globalvars.password;
				cs.Role = globalvars.role;
				cs.Dialect = 3;
				cs.Charset = "ISO8859_1";
				
				ConnectionString = cs.ToString ();
				
//				System.Console.WriteLine("Cadena de Conexión:["+ConnectionString+"]");
				
				FbConnection _conn = new FbConnection (ConnectionString);
				
//				System.Console.WriteLine("Conexin DB Creada...");
				
//				System.Console.WriteLine("Conectando a la base de datos...");
				_conn.Open ();
				
				FbTransaction _transaction = _conn.BeginTransaction ();
//				System.Console.WriteLine("Transaction Iniciada...");
				
//				System.Console.WriteLine("Sentencia llega:{0}",sentencia);
				
				FbCommand _query = new FbCommand(sentencia, _conn, _transaction);
				
				int _rows = _query.ExecuteNonQuery ();
				
				_transaction.Commit ();
//				System.Console.WriteLine("Transaccin Finalizada...");
				_query.Dispose();
//				System.Console.WriteLine("Command Liberado...");
				_conn.Close();
//				System.Console.WriteLine("Conexin DB cerrada...");

				_consulta.SetAttribute("campos","1");
				_consulta.SetAttribute("campotipo1","INTEGER");
				_consulta.SetAttribute("camponombre1","FILAS_AFECTADAS");
				_consulta.SetAttribute("campotamano1","0");
				XmlElement _registro = _xmldocret.CreateElement("","Registro","");
				XmlElement _campo = _xmldocret.CreateElement("","campo","");
				_campo.InnerText = Convert.ToString(_rows);
				_registro.AppendChild(_campo);
				_consulta.AppendChild(_registro);
				_root.AppendChild(_consulta);
			}

			internal void fDelete(int i, string sentencia)
			{
				string ConnectionString;
				FbConnectionStringBuilder cs = new FbConnectionStringBuilder ();
				string _xmlelementstr = String.Format("{0}{1:000}","consulta",i);
				
//				System.Console.WriteLine("Ejecutando Consulta Delete, xmlelementstr:"+_xmlelementstr);
				
				XmlElement _consulta = _xmldocret.CreateElement("",_xmlelementstr,"");
				
//				System.Console.WriteLine("Elemento consulta, creado...");

				cs.DataSource = globalvars.server;
				cs.Database = globalvars.database;
				cs.UserID = globalvars.user;
				cs.Password = globalvars.password;
				cs.Role = globalvars.role;
				cs.Dialect = 3;
				cs.Charset = "ISO8859_1";
				
				ConnectionString = cs.ToString ();
				
//				System.Console.WriteLine("Cadena de Conexin:["+ConnectionString+"]");
				
				FbConnection _conn = new FbConnection (ConnectionString);
				
//				System.Console.WriteLine("Conexin DB Creada...");
				
//				System.Console.WriteLine("Conectando a la base de datos...");
				_conn.Open ();
				
				FbTransaction _transaction = _conn.BeginTransaction ();
//				System.Console.WriteLine("Transaction Iniciada...");
				
//				System.Console.WriteLine("Sentencia llega:{0}",sentencia);
				
				FbCommand _query = new FbCommand(sentencia, _conn, _transaction);
				
				int _rows = _query.ExecuteNonQuery ();
				
				_transaction.Commit ();
//				System.Console.WriteLine("Transaccin Finalizada...");
				_query.Dispose();
//				System.Console.WriteLine("Command Liberado...");
				_conn.Close();
//				System.Console.WriteLine("Conexin DB cerrada...");

				_consulta.SetAttribute("campos","1");
				_consulta.SetAttribute("campotipo1","INTEGER");
				_consulta.SetAttribute("camponombre1","FILAS_AFECTADAS");
				_consulta.SetAttribute("campotamano1","0");
				XmlElement _registro = _xmldocret.CreateElement("","Registro","");
				XmlElement _campo = _xmldocret.CreateElement("","campo","");
				_campo.InnerText = Convert.ToString(_rows);
				_registro.AppendChild(_campo);
				_consulta.AppendChild(_registro);
				_root.AppendChild(_consulta);
			}

			internal void fUpdate(int i, string sentencia)
			{
				string ConnectionString;
				FbConnectionStringBuilder cs = new FbConnectionStringBuilder ();
				string _xmlelementstr = String.Format("{0}{1:000}","consulta",i);
				
//				System.Console.WriteLine("Ejecutando Consulta Update, xmlelementstr:"+_xmlelementstr);
				
				XmlElement _consulta = _xmldocret.CreateElement("",_xmlelementstr,"");
				
//				System.Console.WriteLine("Elemento consulta, creado...");

				cs.DataSource = globalvars.server;
				cs.Database = globalvars.database;
				cs.UserID = globalvars.user;
				cs.Password = globalvars.password;
				cs.Role = globalvars.role;
				cs.Dialect = 3;
				cs.Charset = "ISO8859_1";
				
				ConnectionString = cs.ToString ();
				
//				System.Console.WriteLine("Cadena de Conexin:["+ConnectionString+"]");
				
				FbConnection _conn = new FbConnection (ConnectionString);
				
//				System.Console.WriteLine("Conexin DB Creada...");
				
//				System.Console.WriteLine("Conectando a la base de datos...");
				_conn.Open ();
				
				FbTransaction _transaction = _conn.BeginTransaction ();
//				System.Console.WriteLine("Transaction Iniciada...");
				
//				System.Console.WriteLine("Sentencia llega:{0}",sentencia);
				
				FbCommand _query = new FbCommand(sentencia, _conn, _transaction);
				
				int _rows = _query.ExecuteNonQuery ();
				
				_transaction.Commit ();
//				System.Console.WriteLine("Transaccin Finalizada...");
				_query.Dispose();
//				System.Console.WriteLine("Command Liberado...");
				_conn.Close();
//				System.Console.WriteLine("Conexin DB cerrada...");

				_consulta.SetAttribute("campos","1");
				_consulta.SetAttribute("campotipo1","INTEGER");
				_consulta.SetAttribute("camponombre1","FILAS_AFECTADAS");
				_consulta.SetAttribute("campotamano1","0");
				XmlElement _registro = _xmldocret.CreateElement("","Registro","");
				XmlElement _campo = _xmldocret.CreateElement("","campo","");
				_campo.InnerText = Convert.ToString(_rows);
				_registro.AppendChild(_campo);
				_consulta.AppendChild(_registro);
				_root.AppendChild(_consulta);
			}
			
			internal void fExecute(int i, string sentencia)
			{
				string ConnectionString;
				FbConnectionStringBuilder cs = new FbConnectionStringBuilder ();
				string _xmlelementstr = String.Format("{0}{1:000}","consulta",i);
				
//				System.Console.WriteLine("Ejecutando Consulta Update, xmlelementstr:"+_xmlelementstr);
				
				XmlElement _consulta = _xmldocret.CreateElement("",_xmlelementstr,"");
				
//				System.Console.WriteLine("Elemento consulta, creado...");

				cs.DataSource = globalvars.server;
				cs.Database = globalvars.database;
				cs.UserID = globalvars.user;
				cs.Password = globalvars.password;
				cs.Role = globalvars.role;
				cs.Dialect = 3;
				cs.Charset = "ISO8859_1";
				
				ConnectionString = cs.ToString ();
				
//				System.Console.WriteLine("Cadena de Conexin:["+ConnectionString+"]");
				
				FbConnection _conn = new FbConnection (ConnectionString);
				
//				System.Console.WriteLine("Conexin DB Creada...");
				
//				System.Console.WriteLine("Conectando a la base de datos...");
				_conn.Open ();
				
				FbTransaction _transaction = _conn.BeginTransaction ();
//				System.Console.WriteLine("Transaction Iniciada...");
				
//				System.Console.WriteLine("Sentencia llega:{0}",sentencia);
				
				FbCommand _query = new FbCommand(sentencia, _conn, _transaction);
				
				int _rows = _query.ExecuteNonQuery ();
				
				_transaction.Commit ();
//				System.Console.WriteLine("Transaccin Finalizada...");
				_query.Dispose();
//				System.Console.WriteLine("Command Liberado...");
				_conn.Close();
//				System.Console.WriteLine("Conexin DB cerrada...");

				_consulta.SetAttribute("campos","1");
				_consulta.SetAttribute("campotipo1","INTEGER");
				_consulta.SetAttribute("camponombre1","FILAS_AFECTADAS");
				_consulta.SetAttribute("campotamano1","0");
				XmlElement _registro = _xmldocret.CreateElement("","Registro","");
				XmlElement _campo = _xmldocret.CreateElement("","campo","");
				_campo.InnerText = Convert.ToString(_rows);
				_registro.AppendChild(_campo);
				_consulta.AppendChild(_registro);
				_root.AppendChild(_consulta);
			}
			
			internal int ValidarTipo(string tipo)
			{
				if(tipo=="select"){return 0;}
				if(tipo=="insert"){return 1;}
				if(tipo=="delete"){return 2;}
				if(tipo=="update"){return 3;}
				if(tipo=="drop"){return 4;}
				if(tipo=="alter"){return 5;}
				if(tipo=="create"){return 6;}
				if(tipo=="revoke"){return 7;}
				if(tipo=="grant"){return 8;}
				return -1;
			}
			
			public string ReturnString()
			{
				return _returnstr;
			}
	
		}

}
