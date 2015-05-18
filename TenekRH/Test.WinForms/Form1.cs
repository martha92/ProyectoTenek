using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Test.WinForms
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            WSTenekRH.ServicesSoapClient ws = new WSTenekRH.ServicesSoapClient();
            //var response = ws.Login("madelacruz", "admin");
            var response = ws.TraeEmpleado("1001");
            //textBox1.Text = response.to;
        }
    }
}
