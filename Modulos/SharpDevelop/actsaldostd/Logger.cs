using System;
using System.IO;
using System.Text;

namespace actsaldostd
{
	/// <summary>
	/// Description of Logger.
	/// </summary>
	public class CreateLogFiles
	{
		
		private static string sLogFormat;
		private static string sErrorTime;

		
		public static void ErrorLog(string sPathName, string sErrMsg)
		{
			
			if (!File.Exists(sPathName)){
				FileStream fs = File.Create(sPathName);
				fs.Close();
        	}
        	try {
				StreamWriter sw = File.AppendText(sPathName);
	    		sLogFormat = DateTime.Now.ToShortDateString().ToString()+" "+DateTime.Now.ToLongTimeString().ToString()+" ==> ";
    			string sYear    = DateTime.Now.Year.ToString();
    			string sMonth    = DateTime.Now.Month.ToString();
    			string sDay    = DateTime.Now.Day.ToString();
    			sErrorTime = sYear+sMonth+sDay;
    		
	    		sw.WriteLine(sLogFormat + sErrMsg);
    			sw.Flush();
    			sw.Close();
			}
			catch (Exception e) {
          		Console.WriteLine(e.Message.ToString());			
			}
		}
	}
}
