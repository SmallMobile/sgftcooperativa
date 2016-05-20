/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/10/04
 * Hora: 02:06 p.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */

using System;
using System.Text;
using System.Xml;
using System.Data;

namespace actsaldostd
{
	/// <summary>
	/// Description of XmlFBParse.
	/// </summary>
	public class XmlFBParse
	{
			private Encoding _mEncoding;
			
			XmlDocument _xmldoc = new XmlDocument ();
			XmlElement _root;
			XmlElement _querys;
		
			
			public Encoding MEncoding {
				get { return _mEncoding; }
				set { _mEncoding = value; }
			}

			
			public XmlFBParse()
			{
				
				_root = _xmldoc.CreateElement("","query_info","");
				_querys = _xmldoc.CreateElement("","querys","");
				
				_xmldoc.AppendChild(_root);
				_root.AppendChild(_querys);				
			}
			
			public string XmlString()
			{
				return _xmldoc.OuterXml;
			}
			
			public void AddQuery(stdData _str)
			{
				
				XmlElement _query01 = _xmldoc.CreateElement("","query","");
				XmlElement _query02 = _xmldoc.CreateElement("","query","");
				XmlElement _tipo01 = _xmldoc.CreateElement("","tipo","");
				XmlElement _sentencia01 = _xmldoc.CreateElement("","sentencia","");
				XmlElement _tipo02 = _xmldoc.CreateElement("","tipo","");
				XmlElement _sentencia02 = _xmldoc.CreateElement("","sentencia","");
				
				_tipo01.InnerText = "delete";
				StringBuilder _querystr = new StringBuilder();
				_querystr.Append("delete from TDB$SALDO where ");
				_querystr.Append("TDB$SALDO.TARJETA ='"+_str.id_tarjeta+"'");
				
				_sentencia01.InnerText = _querystr.ToString();
				
				_query01.AppendChild(_tipo01);
				_query01.AppendChild(_sentencia01);
				_querys.AppendChild(_query01);
				
				_tipo02.InnerText = "insert";
				
				_querystr.Remove(0,_querystr.Length);
				_querystr.Append("insert into TDB$SALDO (TARJETA, SALDODISPONIBLE,SALDOTOTAL,FECHA,HORA,ID_AGENCIA) values (");
				_querystr.Append("'"+_str.id_tarjeta + "',");
				_querystr.Append(_str.disponible.ToString("#0")  + ",");
				_querystr.Append(_str.saldo.ToString("#0")  + ",");
				_querystr.Append("'" + DateTime.Now.ToString("yyyy/MM/dd") + "',");
				_querystr.Append("'" + DateTime.Now.ToString("HH:mm:ss") + "',");
				_querystr.Append(_str.id_agencia.ToString() + ")");
				
				_sentencia02.InnerText = _querystr.ToString();

				_query02.AppendChild(_tipo02);
				_query02.AppendChild(_sentencia02);
				_querys.AppendChild(_query02);
				
			}
	}

}
