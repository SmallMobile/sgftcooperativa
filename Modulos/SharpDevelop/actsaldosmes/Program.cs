/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/12/01
 * Hora: 09:06 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System;
using System.Data;
using System.Configuration;
using FirebirdSql.Data.FirebirdClient;

namespace actsaldosmes
{
	class Program
	{
		
		public static void Main()
		{
			globalvars.server = ConfigurationSettings.AppSettings["server"];
			globalvars.user = ConfigurationSettings.AppSettings["user"];
			globalvars.password = ConfigurationSettings.AppSettings["password"];
			globalvars.database = ConfigurationSettings.AppSettings["database"];
			globalvars.role = ConfigurationSettings.AppSettings["role"];
			globalvars.Logfile = ConfigurationSettings.AppSettings["logfile"];

			Procesar _exec = new Procesar();
			_exec.Execute();
		}
	}
	
}
