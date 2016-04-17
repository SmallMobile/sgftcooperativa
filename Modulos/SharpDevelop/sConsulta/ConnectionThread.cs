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


namespace sConsulta
{
	/// <summary>
	/// Description of ConnectionThread.
	/// </summary>
	public class ConnectionThread
	{
			public TcpListener threadListener;
			private static int connections = 0;
			private Encoding _mEncoding;
		
			public void HandleConnection(object state)
			{
				TcpClient client = threadListener.AcceptTcpClient();
				NetworkStream ns = client.GetStream();
				BinaryReader rd = new BinaryReader(ns);
				BinaryWriter wr = new BinaryWriter(ns);
				StringBuilder _receiveStr = new StringBuilder();
				int sizercv = 0;
				
				string RemoteIP;
				string RemotePort;
				
				RemoteIP = ((IPEndPoint)client.Client.RemoteEndPoint).Address.ToString ();
				RemotePort = ((IPEndPoint)client.Client.RemoteEndPoint).Port.ToString ();
				
				CreateLogFiles.ErrorLog(globalvars.Logfile,"cliente Conectado:"+RemoteIP+", desde puerto:"+RemotePort);
				
				connections++;
				
				CreateLogFiles.ErrorLog(globalvars.Logfile,"conexiones activas:"+Convert.ToString(connections));
				
				_mEncoding = Encoding.GetEncoding(28591); // ISO-8859-1
				
				string waiting = "Esperando...\r\n";
				wr.Write(_mEncoding.GetBytes(waiting));
			
	 			int size = -1;
				
				size = IPAddress.NetworkToHostOrder(rd.ReadInt32());
				byte [] data = new byte[size];
				data = rd.ReadBytes(size);
				_receiveStr.AppendFormat("{0}",_mEncoding.GetString(data,0,size));

				XmlFBParse qr = new XmlFBParse(RemoteIP);
				qr.Receivestr = _receiveStr.ToString();
				qr.ExecuteQuery ();
				string _returnStr = qr.ReturnString();
				
				byte[] rbuffer = _mEncoding.GetBytes(_returnStr);
				
				wr.Write(IPAddress.HostToNetworkOrder(rbuffer.Length));
				wr.Write(rbuffer,0,rbuffer.Length);
				
				wr.Close();
				rd.Close();
				ns.Close();
				client.Close();
				connections--;
				CreateLogFiles.ErrorLog(globalvars.Logfile,"cliente desconectado:"+RemoteIP);
				CreateLogFiles.ErrorLog(globalvars.Logfile,"conexiones activas:"+Convert.ToString(connections));
				
			}
			
		}
}
