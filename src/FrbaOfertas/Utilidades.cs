using FrbaOfertas;
using FrbaOfertas.Properties;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace FrbaOfertas
{   
    
    class Utilidades
    {
       /*public static SqlConnection Conectar()
          {
          AppConfig ArchivoConfig = new AppConfig();
          SqlConnection Con = new SqlConnection(ArchivoConfig.obtenerHost());
          return Con;
          }*/

      
      
        public static SqlConnection Conectar()
            {
              SqlConnection Con = new SqlConnection("Data Source=localhost\\SQLSERVER2012;Initial Catalog=GD2C2019;User ID=gdCupon2019;Password=gd2019");
              return Con;
            }

        
        public static DataSet Ejecutar(string cmd)
           {
              SqlConnection Con = Conectar();
              Con.Open();
              DataSet Dset = new DataSet();
              SqlDataAdapter DPter = new SqlDataAdapter(cmd, Con);

              DPter.Fill(Dset);

              Con.Close();

              return Dset;
            }


        public static Boolean VerificarCuentaHabilitada(string ID)
           {
               Boolean CuentaResultado = false;
               SqlConnection Con = Conectar();
               Con.Open();

               SqlCommand cm = new SqlCommand("execute JJFG.VerificarCuentaHabilitada'" + ID + "'", Con);
               SqlDataReader dr = cm.ExecuteReader();

               if (dr.Read())
               {
                   CuentaResultado = true;
               }
               dr.Close();
               Con.Close();

               return CuentaResultado;
           }


        public static Boolean  VerificarPassword(String password)
            {
            Boolean PasswordResultado = false;
            SqlConnection Con = Conectar();
            Con.Open();

            SqlCommand cm = new SqlCommand("exec JJFG.VerificarPassword'" + password + "'", Con);
            SqlDataReader dr = cm.ExecuteReader();

            if (dr.Read())
               {
                PasswordResultado = true;
                }
            dr.Close();
            Con.Close();

            return PasswordResultado;
            }
        

        public static int obtenerLoginFallidos(String ID)
            {
               SqlConnection Con = Conectar();
               Con.Open();

               SqlCommand cmd = new SqlCommand("exec JJFG.obtenerLoginFallidos'" + ID + "'", Con);
    
               int cantidad = Convert.ToInt32(cmd.ExecuteScalar());
                              
               Con.Close(); 
               return (cantidad); 
            }


        public static void SumarUnLoginFallido(String ID)
            { 
               SqlConnection Con = Conectar();
               Con.Open();

               SqlCommand cm = new SqlCommand("execute JJFG.SumarUnLoginFallido'" + ID + "'", Con);
               cm.ExecuteNonQuery();
                                 
               Con.Close();   
            }


        public static void ResetearLoginFallido(string ID)
            {
               SqlConnection Con = Conectar();
               Con.Open();

               SqlCommand cm = new SqlCommand("execute JJFG.ResetearLoginFallido'" + ID + "'", Con);
               cm.ExecuteNonQuery();
                
               Con.Close();   
            } 

        public static int TraerRolId(String ID)
            {
               SqlConnection Con = Conectar();
               Con.Open();

               SqlCommand cmd = new SqlCommand("exec JJFG.TraerRolId'" + ID + "'", Con);

               int Rol_ID = Convert.ToInt32(cmd.ExecuteScalar());

               Con.Close();
               return (Rol_ID);
            }

    }
}
