/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/10/02
 * Hora: 02:27 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Configuration;


namespace sConsulta
{
	public class Program
	{

		public static void Main()
		{

			globalvars.host = System.Configuration.ConfigurationSettings.AppSettings["host"];
			globalvars.port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"]);
			globalvars.server = ConfigurationSettings.AppSettings["server"];
			globalvars.user = ConfigurationSettings.AppSettings["user"];
			globalvars.password = ConfigurationSettings.AppSettings["password"];
			globalvars.database = ConfigurationSettings.AppSettings["database"];
			globalvars.role = ConfigurationSettings.AppSettings["role"];
			globalvars.Logfile = ConfigurationSettings.AppSettings["logfile"];
			Console.Out.WriteLine("LogFile:" + globalvars.Logfile);
			Console.Out.WriteLine("Host:" + globalvars.host);
			
		    CreateLogFiles Err = new CreateLogFiles();
		    Err.ErrorLog(globalvars.Logfile,"Iniciando Servicio...puerto:"+Convert.ToString(globalvars.port));

        	ThreadPoolTcpSrvr tpts = new ThreadPoolTcpSrvr();
			tpts.Sport = globalvars.port;
			try {
				tpts.Start();
			}
			catch (Exception e)
			{
				Err.ErrorLog(globalvars.Logfile,e.Message);
			}
			Err.ErrorLog(globalvars.Logfile,"cerrando servicio...");
		}
		
		
	}
	
	public class ThreadPoolTcpSrvr
	{
		private TcpListener client;
		private int _port;
		private string _fbserver;
		private string _fbpath;
		private bool _bContinue;
		private Encoding _mEncoding;
		
		public Encoding mEncoding {
			get { return _mEncoding;}
			set { _mEncoding = value;}
		}
		
		public string Fbserver {
			get { return _fbserver; }
			set { _fbserver = value;}
		}
		
		public string Fbpath {
			get { return _fbpath;}
			set { _fbpath = value;}
		}
		
		public int Sport {
			get { return _port;}
			set { _port = value;}
		}
		
		public ThreadPoolTcpSrvr()
		{
			_bContinue = true;
		}
		
		public void Start()
		{
			client = new TcpListener(IPAddress.Any,_port);
			client.Start();
			
			while(_bContinue)
			{
				while (!client.Pending())
				{
					Thread.Sleep(1000);
				}
				ConnectionThread newconnection = new ConnectionThread();
				newconnection.threadListener = this.client;
				ThreadPool.QueueUserWorkItem(new
				           WaitCallback(newconnection.HandleConnection));
			}
		}
	}
		
}
		

