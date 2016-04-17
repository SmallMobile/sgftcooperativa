/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/09
 * Hora: 10:02 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.Collections.Generic;
using System.Drawing;
using System.Windows.Forms;
using System.Text;
using System.IO;
using System.Security.Cryptography;


namespace pruebasDES
{
	/// <summary>
	/// Description of MainForm.
	/// </summary>
	public partial class MainForm : Form
	{
		
		public MainForm()
		{
			//
			// The InitializeComponent() call is required for Windows Forms designer support.
			//
			InitializeComponent();
			
			//
			// TODO: Add constructor code after the InitializeComponent() call.
			//
		}
		
		
		void BtnBuscarClick(object sender, EventArgs e)
		{
			if (openFileDialog1.ShowDialog() == DialogResult.OK)
			{
				edFileName.Text = openFileDialog1.FileName;
			}
		}
		
		void BtnCerrarClick(object sender, EventArgs e)
		{
			this.Close();
		}
		
		void BtnProcesarClick(object sender, EventArgs e)
		{
			
			
			char[] szHead  = new char[3];
			int b_nSize;
			int b_nCrc;
			byte[] vbKey   = new byte[8];
			byte[] data    = new byte[1024];
			
			FileStream file = new FileStream(openFileDialog1.FileName, FileMode.Open,FileAccess.Read);
			Encoding en = Encoding.GetEncoding("ISO-8859-1");
			BinaryReader br = new BinaryReader(file);
			// Leer szHead, valor esperado 'XML'	
			szHead = br.ReadChars(3);
			b_nSize = br.ReadInt32();
			b_nCrc = br.ReadInt32();
			vbKey = br.ReadBytes(8);
			data = br.ReadBytes(b_nSize);
			
			edClaveIngreso.Text = HexEncoding.ToString(vbKey);
		
			string hexdata = HexEncoding.ToString(vbKey);
			string key = "0123456789ABCDEF";
			string hexresult = DESDecrypt(hexdata,key);
		
			edClaveInterna.Text = hexresult;
			
			edDataCifrado.Text = HexEncoding.ToString(data);
			
			hexdata = HexEncoding.ToString(data);
			key = hexresult;
			hexresult = DESDecrypt(hexdata,key);
			
			edDataDescifrado.Text = hexresult;
			
			edXml.Text = HexEncoding.HexToString(hexresult);

		}
		
		void BtnCodificarClick(object sender, EventArgs e)
		{
			

		}
		
		
		public static string DESEncrypt(string message, string key)
		{
			int discarded;
			
    		DESCryptoServiceProvider des = new DESCryptoServiceProvider();
    
    		des.Key = HexEncoding.GetBytes(key,out discarded);

    		des.Mode = CipherMode.ECB;
    		
    		des.Padding = PaddingMode.Zeros;

	    	ICryptoTransform encryptor = des.CreateEncryptor();
    
    		byte[] data = HexEncoding.GetBytes(message, out discarded);

	    	byte[] dataEncrypted = encryptor.TransformFinalBlock(data, 0, data.Length);

    		return HexEncoding.ToString(dataEncrypted);
		}

		public static string DESDecrypt(string message, string key)
		{ 
			int discarded;
			
    		DESCryptoServiceProvider des = new DESCryptoServiceProvider();
    		
    		des.Key = HexEncoding.GetBytes(key,out discarded);
    		
    		des.Mode = CipherMode.ECB;
    		
    		des.Padding = PaddingMode.Zeros;
     
	    	ICryptoTransform decryptor = des.CreateDecryptor();
            
    		byte[] data = HexEncoding.GetBytes(message, out discarded);

	    	byte[] dataDecrypted = decryptor.TransformFinalBlock(data, 0, data.Length);

    		return HexEncoding.ToString(dataDecrypted);
		}			
		
	}
}
