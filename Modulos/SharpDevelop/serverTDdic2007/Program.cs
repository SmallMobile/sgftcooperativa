/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/12/17
 * Hora: 08:32 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System;
using System.Configuration;

namespace serverTD
{
	class Program
	{
		public static void Main(string[] args)
		{
			globalvars.host = ConfigurationSettings.AppSettings["host"];
			globalvars.port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"]);
			globalvars.server = ConfigurationSettings.AppSettings["server"];
			globalvars.user = ConfigurationSettings.AppSettings["user"];
			globalvars.password = ConfigurationSettings.AppSettings["password"];
			globalvars.database = ConfigurationSettings.AppSettings["database"];
			globalvars.role = ConfigurationSettings.AppSettings["role"];
			globalvars.Logfile = ConfigurationSettings.AppSettings["logfile"];
			globalvars.Remotehost = ConfigurationSettings.AppSettings["remotehost"];
			globalvars.Constkey = ConfigurationSettings.AppSettings["constkey"];
			// Crear y Ejecutar servidor UDP
			UdpServer udpsvr = new UdpServer(globalvars.port);
		}
	}
}
