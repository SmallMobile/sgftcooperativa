/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/10/04
 * Hora: 02:07 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;


namespace actsaldostd
{
	/// <summary>
	/// Description of ConnectionThread.
	/// </summary>
	public class ClientTcp
	{
		private Encoding _mEncoding;
		private string _xmlString;
		private Socket server;
		
		public string XmlString {
			get { return _xmlString; }
			set { _xmlString = value; }
		}
		
		public bool SendData()
		{

			_mEncoding = Encoding.GetEncoding(28591);
			
			IPEndPoint ipep = new IPEndPoint(IPAddress.Parse(globalvars.Remotehost), globalvars.Remoteport);
			EndPoint _ipep = (EndPoint)ipep;

			server = new Socket(AddressFamily.InterNetwork,SocketType.Stream, ProtocolType.Tcp);

			try
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Conectando a Servidor:"+globalvars.Remotehost+":"+globalvars.Remoteport.ToString());
				server.Connect(_ipep);
			} catch (SocketException e)
			{
				CreateLogFiles.ErrorLog(globalvars.Logfile,"Imposible conectar al servidor remoto...");
				CreateLogFiles.ErrorLog(globalvars.Logfile,e.ToString());
				return false;
			}


			NetworkStream ns = new NetworkStream(server);
			BinaryReader br = new BinaryReader(ns);
			BinaryWriter bw = new BinaryWriter(ns);
			StreamReader sr = new StreamReader(ns);

			string _header = sr.ReadLine();
			
			if (_header == "Esperando...")
			{
				//<TODO> Enviar Datos al Servidor de Consultas
				//</TODO>
				byte[] _buffer = _mEncoding.GetBytes(_xmlString);
				bw.Write(IPAddress.HostToNetworkOrder(_buffer.Length));
				bw.Write(_buffer,0,_buffer.Length);
				bw.Flush();

/*				int size = br.ReadInt32();
				size = IPAddress.NetworkToHostOrder(size);
				byte [] data = new byte[size];
				data = br.ReadBytes(size);
*/			}
			
			CreateLogFiles.ErrorLog(globalvars.Logfile,"Desconectando del Servidor...");
			sr.Close();
			br.Close();
			bw.Close();
			ns.Close();
			server.Shutdown(SocketShutdown.Both);
			server.Close();
			
			return true;
			
		}
		
	}
}
