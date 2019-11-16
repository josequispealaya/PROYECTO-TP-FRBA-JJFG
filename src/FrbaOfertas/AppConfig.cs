using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using FrbaOfertas.Properties;

namespace FrbaOfertas
{
   public class AppConfig
    {
        public String obtenerHost()
        {
            return Settings.Default.GD2C2019ConnectionString;
        }

        public String obtenerFecha()
        {
            return ConfigurationManager.AppSettings["fecha"];
        }
    }
}
