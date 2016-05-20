/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/19
 * Hora: 12:03 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;

namespace sTarjetaD
{
	[Flags]
	public enum Causal
	{
		Compra=0,
		Retiro=1,
		Anulacion=20,
		Consignacion=22,
		Consulta1=30,
		Consulta2=31
	}
	
	public enum Mensajes
	{
		Peticion=200,
		Respuesta_Peticion=210,
		Reintento_Peticion=220,
		Re_Reintento_Peticion=221,
		Respuesta_Reintento=230,
		Reverso=420,
		R_Reverso=421,
		Respuesta_Reverso=430
	}
	
	public enum Errores
	{
		Bien=0,
		Invalida=56,
		Insuficiente=51,
		Vencida=54
	}
	
	/// <summary>
	/// Description of globalvars.
	/// </summary>
	public static class globalvars
	{
//		private static string _host;
		private static int    _port;
		private static string _server;
		private static string _database;
		private static string _user;
		private static string _password;
		private static string _role;
		private static string _logfile;
		private static string _remotehost;

		
		public static string Remotehost {
			get { return _remotehost; }
			set { _remotehost = value; }
		}
		
		public static string Logfile {
			get { return _logfile; }
			set { _logfile = value; }
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
