/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/10/04
 * Hora: 02:31 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;

namespace sConsulta
{
	/// <summary>
	/// Description of globalvars.
	/// </summary>
	public static class globalvars
	{
		
		private static string _host;
		private static int _port;
		private static string _server;
		private static string _database;
		private static string _user;
		private static string _password;
		private static string _role;
		private static string _logfile;
		
		public static string Logfile {
			get { return _logfile; }
			set { _logfile = value; }
		}
		
		public static string host
		{
			get {return _host;}
			set {_host = value;}
		}
				
		public static int port
		{
			get {return _port;}
			set {_port = value;}
		}
		
		public static string server
		{
			get {return _server;}
			set {_server = value;}
		}
		
		public static string database
		{
			get {return _database;}
			set {_database = value;}
		}
		
		public static string user
		{
			get {return _user;}
			set {_user = value;}
		}
		
		public static string password
		{
			get {return _password;}
			set {_password = value;}
		}
		
		public static string role
		{
			get {return _role;}
			set {_role = value;}
		}
		
	}
}
