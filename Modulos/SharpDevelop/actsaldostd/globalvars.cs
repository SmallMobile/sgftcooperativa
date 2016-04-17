using System;

namespace actsaldostd
{
	/// <summary>
	/// Estructura que contiene la información necesaria para crear
	/// los querys de actualización de saldos
	/// <param name="id_agencia">código de la agencia</param>
	/// <param name="id_tipo_captacion">tipo de captación 2-rindediario,4-juvenil</param>
	/// <param name="numero_cuenta">número de cuenta a afectar</param> 
	/// <param name="digito_cuenta">digito de control de la cuenta a afectar</param>
	/// <param name="id_tarjeta">código tarjeta débito correspondiente a la cuenta</param>
	/// <param name="saldo">saldo total a ser reportado</param>
	/// <param name="disponible">saldo disponible a ser reportado</param> 
	/// </summary>
	public struct stdData{
		public int	id_agencia;
		public int id_tipo_captacion;
		public int numero_cuenta;
		public int digito_cuenta;
		public string id_tarjeta;
		public decimal saldo;
		public decimal disponible;
	}
	/// <summary>
	/// Variables Globales.
	/// </summary>
	/// 
	public static class globalvars
	{
		
		private static string _server;
		private static string _database;
		private static string _user;
		private static string _password;
		private static string _role;
		private static string _logfile;
		private static int _interval;
		private static string _remotehost;
		private static int _remoteport;
		
		public static int Remoteport {
			get { return _remoteport; }
			set { _remoteport = value; }
		}
		
		public static string Remotehost {
			get { return _remotehost; }
			set { _remotehost = value; }
		}
		
		public static int Interval {
			get { return _interval; }
			set { _interval = value; }
		}
		
		public static string Logfile {
			get { return _logfile; }
			set { _logfile = value; }
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
