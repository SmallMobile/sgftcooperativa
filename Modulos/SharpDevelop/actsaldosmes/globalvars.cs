using System;

namespace actsaldosmes
{
	/// <summary>
	/// Description of globalvars.
	/// </summary>
	public static class globalvars
	{
		
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
