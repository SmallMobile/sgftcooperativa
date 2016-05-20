/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/12/12
 * Hora: 09:55 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System;
using System.Configuration;

namespace actsaldostd
{
	class Program
	{
		public static void Main(string[] args)
		{
			globalvars.server = ConfigurationSettings.AppSettings["server"];
			globalvars.user = ConfigurationSettings.AppSettings["user"];
			globalvars.password = ConfigurationSettings.AppSettings["password"];
			globalvars.database = ConfigurationSettings.AppSettings["database"];
			globalvars.role = ConfigurationSettings.AppSettings["role"];
			globalvars.Logfile = ConfigurationSettings.AppSettings["logfile"];
			globalvars.Interval = Convert.ToInt32(ConfigurationSettings.AppSettings["interval"]);
			globalvars.Remotehost = ConfigurationSettings.AppSettings["remotehost"];
			globalvars.Remoteport = Convert.ToInt32(ConfigurationSettings.AppSettings["remoteport"]);
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Actualizador de Saldos TD Activado...");			
			
			Clock _watch = new Clock();
			while (true){
				
			}
		}
	}
}
