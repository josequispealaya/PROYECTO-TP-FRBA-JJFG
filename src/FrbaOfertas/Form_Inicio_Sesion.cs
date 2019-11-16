using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using FrbaOfertas;

namespace FrbaOfertas
{
    public partial class FormInicioSesion : Form
    {
        public FormInicioSesion()
        {
            InitializeComponent();
        }

        private void btn_Ingresar_Click_1(object sender, EventArgs e)
        {
            try
            {
            String cmd = String.Format("Select * from JJFG.USUARIO where Usua_Username = '{0}'", txtUserName.Text.Trim());

                DataSet DS = Utilidades.Ejecutar(cmd);

                 if (DS.Tables[0].Rows.Count > 0)
                     {

                        String nombre = DS.Tables[0].Rows[0]["Usua_UserName"].ToString().Trim();
                        String password = txtPassword.Text.Trim();
                        String ID = DS.Tables[0].Rows[0]["Usua_ID"].ToString().Trim();
                        
                     if (Utilidades.VerificarCuentaHabilitada(ID))
                       {
                          
                          if (Utilidades.VerificarPassword(password))
                             {
                                Utilidades.ResetearLoginFallido(ID);

                                // MessageBox.Show("ACCEDISTE AL SISTEMA!!!");

                                // Se ingresó al sistema

                                int Rol_ID = Utilidades.TraerRolId(ID);
                              
                                 switch (Rol_ID)
                                        {
                                        case 1:
                                            // Se ingresa como Administrador

                                           // MessageBox.Show("Ingresamos como administrador");

                                            this.Hide();
                                            Form FormAdministrador = new FormAdministrador();
                                            FormAdministrador.Show();
                                            break;

                                        case 2:
                                            // Se ingresa como Cliente

                                            //MessageBox.Show("Ingresamos como Cliente");
                                            this.Hide();
                                            Form FormCliente = new FormCliente();
                                            FormCliente.Show();
                                            break;
                                        
                                       
                                        case 3:
                                            // Se ingresa como Proveedor
                                            //MessageBox.Show("Ingresamos como Proveedor");
                                            this.Hide();
                                            Form FormProveedor = new FormProveedor();
                                            FormProveedor.Show();
                                            break;

                                        default:
                                            throw new Exception(String.Format("rol desconocido: {0}", Rol_ID));
                                        }

                              }
                            else
                              {
                                 if (nombre == "admin")
                                  {
                                     MessageBox.Show("Contraseña admin Incorrecta");
                                  }
                                 else 
                                  {
                                     int cantidad = Utilidades.obtenerLoginFallidos(ID);

                                     switch (cantidad)
                                         {

                                         case 0:

                                             Utilidades.SumarUnLoginFallido(ID);
                                             MessageBox.Show("Contraseña Incorrecta");
                                             break;

                                         case 1:

                                              Utilidades.SumarUnLoginFallido(ID);
                                              MessageBox.Show(nombre + ": Ha Ingresado dos veces su contraseña en forma incorrecta, si el próximo intento es incorrecto el sistema bloqueará su cuenta. ");
                                              break;

                                         case 2:

                                              Utilidades.SumarUnLoginFallido(ID);
                                              MessageBox.Show("Contraseña Incorrecta\n\n" + nombre + ": Ha Ingresado tres veces su contraseña en forma incorrecta.\n El sistema bloqueó su cuenta.\n Por favor comuníquese con el Administrador del sistema. ");
                                              break;

                                          }
                                    }
                               }
                              
                            //  this.Close();
                        
                      }
                     else
                      {
                        MessageBox.Show(nombre + ":  Su cuenta se encuentra Bloqueada ó Eliminada, por favor comuníquese con el Administrador del sistema.");
                        //this.Close();
                      }


                }
                else
                {
                     String nombre = txtUserName.Text.Trim();
                     MessageBox.Show("El Usuario:  " + nombre + "  No se encuentra registrado en el Sistema ");
                }

            }
        catch (Exception error)
            {
                MessageBox.Show("No se pudo Conectar con el Servidor: " + error);
            }
        }


        private void btnRegistrarUsuario_Click(object sender, EventArgs e)
            {
            String rol = comboBox1.Text.Trim();

            if (rol != "")
                {

                switch (rol)
                    {
                    case "Cliente":

                        this.Hide();
                        Form FormGenerarCliente = new FormGenerarCliente();
                        FormGenerarCliente.Show();
                        break;


                    case "Proveedor":

                        this.Hide();
                        Form FormGenerarProveedor = new FormGenerarProveedor();
                        FormGenerarProveedor.Show();
                        break;

                    default:
                        throw new Exception(String.Format("rol desconocido: {0}", rol));
                    }
                }
            else
                {
                MessageBox.Show("Por Favor Elija un ROL ");  
                }
         }

        private void btnSalir_Click(object sender, EventArgs e)
            {
               Application.Exit();
            }

    
    }
}
