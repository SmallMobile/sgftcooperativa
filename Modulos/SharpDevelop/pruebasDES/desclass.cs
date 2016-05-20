/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/09
 * Hora: 10:11 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Security.Cryptography;
using Utility;

namespace pruebasDES
{
	/// <summary>
	/// Description of desclass.
	/// </summary>
	public class desclass
	{
		private byte[] _clave;
		private byte[] _texto;
		
		public byte[] Texto {
			get { return _texto; }
			set { _texto= value; }
		}
		
		public byte[] Clave {
			get { return _clave; }
			set { _clave = value; }
		}
		public desclass()
		{
		}
		
		public byte[] Encriptar()
		{
			Encoding en = Encoding.GetEncoding("ISO-8859-1");
			if (_clave.Length <= 0 )
			{
				MessageBox.Show("Debe ingresar una clave valida...");
				return en.GetBytes("error");
			}
			else
			{
				if (_clave.Length == 8)
				{
					DES des = new DESCryptoServiceProvider();
					des.Mode = CipherMode.CBC;
					
					byte[] textoplano = _texto;
					byte[] key = _clave;
					byte[] IV = _clave;
					des.Key = key;
					des.IV = IV;
					ICryptoTransform transform = des.CreateEncryptor(des.Key,des.IV);
					MemoryStream memStreamEncryptedData = new MemoryStream();
					
					memStreamEncryptedData.Write(textoplano,0,textoplano.Length);
					
					CryptoStream encStream = new CryptoStream(memStreamEncryptedData,transform, CryptoStreamMode.Write);
					byte[] textocipher = memStreamEncryptedData.ToArray();
					
					return textocipher;
				}
				else
				{
					MessageBox.Show("La clave debe ser de 8 caracteres");
					return en.GetBytes("error");
				}
			}
		}
		
		public void DesEncriptar (out byte[] textoplano)
		{
			Encoding en = Encoding.GetEncoding("ISO-8859-1");
			try
			{
				DES des = new DESCryptoServiceProvider();
				des.Mode = CipherMode.CBC;
			
	
				byte[] ciphertext = _texto;
				byte[] key = _clave;
				byte[] IV = {1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1};
				des.Key = key;
				des.IV = IV;
				
				ICryptoTransform transform = des.CreateDecryptor();
				
				MemoryStream memDecryptStream = new MemoryStream();
				memDecryptStream.Write(ciphertext,0,ciphertext.Length);
				CryptoStream cs_decrypt = new CryptoStream(memDecryptStream,transform, CryptoStreamMode.Write);
				
				textoplano = memDecryptStream.ToArray();
				
//				cs_decrypt.Close();
			

			}
			catch (Exception x)
			{
				MessageBox.Show(x.Message);
				textoplano = en.GetBytes("error");
			}
			

		}
		
	}
}
