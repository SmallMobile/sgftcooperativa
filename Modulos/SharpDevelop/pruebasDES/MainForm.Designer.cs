/*
 * Creado por SharpDevelop.
 * Usuario: acruz
 * Fecha: 2007/11/09
 * Hora: 10:02 a.m.
 * 
 * Para cambiar esta plantilla use Herramientas | Opciones | Codificación | Editar Encabezados Estándar
 */
using System.Text;
 
 
namespace pruebasDES
{
	partial class MainForm
	{
		/// <summary>
		/// Designer variable used to keep track of non-visual components.
		/// </summary>
		private System.ComponentModel.IContainer components = null;
		
		/// <summary>
		/// Disposes resources used by the form.
		/// </summary>
		/// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
		protected override void Dispose(bool disposing)
		{
			if (disposing) {
				if (components != null) {
					components.Dispose();
				}
			}
			base.Dispose(disposing);
		}
		
		/// <summary>
		/// This method is required for Windows Forms designer support.
		/// Do not change the method contents inside the source code editor. The Forms designer might
		/// not be able to load this method if it was changed manually.
		/// </summary>
		private void InitializeComponent()
		{
			this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
			this.edFileName = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.btnProcesar = new System.Windows.Forms.Button();
			this.edClaveInterna = new System.Windows.Forms.TextBox();
			this.label4 = new System.Windows.Forms.Label();
			this.edDataCifrado = new System.Windows.Forms.TextBox();
			this.btnCerrar = new System.Windows.Forms.Button();
			this.btnBuscar = new System.Windows.Forms.Button();
			this.edClaveIngreso = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.btnCodificar = new System.Windows.Forms.Button();
			this.edDataDescifrado = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.edXml = new System.Windows.Forms.TextBox();
			this.label5 = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// openFileDialog1
			// 
			this.openFileDialog1.FileName = "openFileDialog1";
			// 
			// edFileName
			// 
			this.edFileName.Location = new System.Drawing.Point(70, 12);
			this.edFileName.Name = "edFileName";
			this.edFileName.Size = new System.Drawing.Size(183, 20);
			this.edFileName.TabIndex = 0;
			// 
			// label1
			// 
			this.label1.Location = new System.Drawing.Point(12, 12);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(52, 23);
			this.label1.TabIndex = 1;
			this.label1.Text = "Archivo:";
			// 
			// label3
			// 
			this.label3.Location = new System.Drawing.Point(12, 58);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(100, 23);
			this.label3.TabIndex = 4;
			this.label3.Text = "Clave Descifrada";
			// 
			// btnProcesar
			// 
			this.btnProcesar.Location = new System.Drawing.Point(286, 10);
			this.btnProcesar.Name = "btnProcesar";
			this.btnProcesar.Size = new System.Drawing.Size(84, 23);
			this.btnProcesar.TabIndex = 5;
			this.btnProcesar.Text = "&Decodificar";
			this.btnProcesar.UseVisualStyleBackColor = true;
			this.btnProcesar.Click += new System.EventHandler(this.BtnProcesarClick);
			// 
			// edClaveInterna
			// 
			this.edClaveInterna.Location = new System.Drawing.Point(104, 58);
			this.edClaveInterna.Name = "edClaveInterna";
			this.edClaveInterna.Size = new System.Drawing.Size(183, 20);
			this.edClaveInterna.TabIndex = 6;
			// 
			// label4
			// 
			this.label4.Location = new System.Drawing.Point(12, 81);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(100, 23);
			this.label4.TabIndex = 7;
			this.label4.Text = "Data Hex Cifrado";
			// 
			// edDataCifrado
			// 
			this.edDataCifrado.Location = new System.Drawing.Point(12, 107);
			this.edDataCifrado.Multiline = true;
			this.edDataCifrado.Name = "edDataCifrado";
			this.edDataCifrado.Size = new System.Drawing.Size(229, 127);
			this.edDataCifrado.TabIndex = 8;
			// 
			// btnCerrar
			// 
			this.btnCerrar.Location = new System.Drawing.Point(376, 53);
			this.btnCerrar.Name = "btnCerrar";
			this.btnCerrar.Size = new System.Drawing.Size(94, 23);
			this.btnCerrar.TabIndex = 9;
			this.btnCerrar.Text = "&Cerrar";
			this.btnCerrar.UseVisualStyleBackColor = true;
			this.btnCerrar.Click += new System.EventHandler(this.BtnCerrarClick);
			// 
			// btnBuscar
			// 
			this.btnBuscar.Location = new System.Drawing.Point(257, 10);
			this.btnBuscar.Name = "btnBuscar";
			this.btnBuscar.Size = new System.Drawing.Size(23, 23);
			this.btnBuscar.TabIndex = 10;
			this.btnBuscar.Text = "...";
			this.btnBuscar.UseVisualStyleBackColor = true;
			this.btnBuscar.Click += new System.EventHandler(this.BtnBuscarClick);
			// 
			// edClaveIngreso
			// 
			this.edClaveIngreso.Location = new System.Drawing.Point(104, 35);
			this.edClaveIngreso.Name = "edClaveIngreso";
			this.edClaveIngreso.Size = new System.Drawing.Size(183, 20);
			this.edClaveIngreso.TabIndex = 14;
			// 
			// label6
			// 
			this.label6.Location = new System.Drawing.Point(12, 35);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(100, 23);
			this.label6.TabIndex = 13;
			this.label6.Text = "Clave Cifrada";
			// 
			// btnCodificar
			// 
			this.btnCodificar.Location = new System.Drawing.Point(376, 9);
			this.btnCodificar.Name = "btnCodificar";
			this.btnCodificar.Size = new System.Drawing.Size(94, 23);
			this.btnCodificar.TabIndex = 15;
			this.btnCodificar.Text = "Codificar";
			this.btnCodificar.UseVisualStyleBackColor = true;
			this.btnCodificar.Click += new System.EventHandler(this.BtnCodificarClick);
			// 
			// edDataDescifrado
			// 
			this.edDataDescifrado.Location = new System.Drawing.Point(257, 107);
			this.edDataDescifrado.Multiline = true;
			this.edDataDescifrado.Name = "edDataDescifrado";
			this.edDataDescifrado.Size = new System.Drawing.Size(229, 127);
			this.edDataDescifrado.TabIndex = 17;
			// 
			// label2
			// 
			this.label2.Location = new System.Drawing.Point(258, 81);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(112, 23);
			this.label2.TabIndex = 16;
			this.label2.Text = "Data Hex DesCifrado";
			// 
			// edXml
			// 
			this.edXml.Location = new System.Drawing.Point(12, 275);
			this.edXml.Multiline = true;
			this.edXml.Name = "edXml";
			this.edXml.Size = new System.Drawing.Size(474, 93);
			this.edXml.TabIndex = 18;
			// 
			// label5
			// 
			this.label5.Location = new System.Drawing.Point(12, 249);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(100, 23);
			this.label5.TabIndex = 19;
			this.label5.Text = "Cadena Descifrada";
			// 
			// MainForm
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(497, 437);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.edXml);
			this.Controls.Add(this.edDataDescifrado);
			this.Controls.Add(this.label2);
			this.Controls.Add(this.btnCodificar);
			this.Controls.Add(this.edClaveIngreso);
			this.Controls.Add(this.label6);
			this.Controls.Add(this.btnBuscar);
			this.Controls.Add(this.btnCerrar);
			this.Controls.Add(this.edDataCifrado);
			this.Controls.Add(this.label4);
			this.Controls.Add(this.edClaveInterna);
			this.Controls.Add(this.btnProcesar);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.label1);
			this.Controls.Add(this.edFileName);
			this.Name = "MainForm";
			this.Text = "pruebasDES";
			this.ResumeLayout(false);
			this.PerformLayout();
		}
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.TextBox edXml;
		private System.Windows.Forms.TextBox edDataDescifrado;
		private System.Windows.Forms.TextBox edDataCifrado;
		private System.Windows.Forms.Button btnCodificar;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.TextBox edClaveIngreso;
		private System.Windows.Forms.Button btnProcesar;
		private System.Windows.Forms.Button btnCerrar;
		private System.Windows.Forms.Button btnBuscar;
		private System.Windows.Forms.TextBox edFileName;
		private System.Windows.Forms.TextBox edClaveInterna;
		private System.Windows.Forms.Label label4;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.OpenFileDialog openFileDialog1;

	}
}
