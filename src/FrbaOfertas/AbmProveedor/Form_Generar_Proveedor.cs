using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas
    {
    public partial class FormGenerarProveedor : Form
        {
        public FormGenerarProveedor()
            {
            InitializeComponent();
            }

        private void btnSalir_Click(object sender, EventArgs e)
            {
            this.Close();
            Form FormInicioSesion = new FormInicioSesion();
            FormInicioSesion.Show();
            }
        }
    }
