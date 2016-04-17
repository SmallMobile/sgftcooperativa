/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/19
 * Hora: 12:02 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System;
using System.Configuration;

namespace sTarjetaD
{
	class Program
	{
		public static void Main(string[] args)
		{
			// Leer Globales
			globalvars.port = Convert.ToInt32(ConfigurationSettings.AppSettings["port"]);
			globalvars.server = ConfigurationSettings.AppSettings["server"];
			globalvars.user = ConfigurationSettings.AppSettings["user"];
			globalvars.password = ConfigurationSettings.AppSettings["password"];
			globalvars.database = ConfigurationSettings.AppSettings["database"];
			globalvars.role = ConfigurationSettings.AppSettings["role"];
			globalvars.Logfile = ConfigurationSettings.AppSettings["logfile"];
			globalvars.Remotehost = ConfigurationSettings.AppSettings["remotehost"];
			// Crear y Ejecutar servidor UDP
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Iniciando Servidor TD UDP...");
			UdpServer udpsvr = new UdpServer(globalvars.port);

		}
	}
}
