using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
//using TenekRH.BusinessObjects;
using System.Web.Script.Serialization;

namespace TenekRH.Services
{
    /// <summary>
    /// Descripción breve de Services
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Services : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos";
        }


        [WebMethod(Description = "Devuelve un string con el numero de empleado")]
        public String Login(String username, String password)
        {
            return Business.Data.Login(username, password);
        }

        [WebMethod]
        public List<Entity.NominaEntity> TraeNomina(String numeroEmpleado)
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string output = jss.Serialize(Business.Data.TraeListaNomina(numeroEmpleado));
            //return output;

            var result = Business.Data.TraeListaNomina(numeroEmpleado);
            return result;
        }

        [WebMethod]
        public List<Entity.EmpleadoEntity> TraeEmpleado(String numeroEmpleado)
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string output = jss.Serialize(Business.Data.TraeListaEmpleado(numeroEmpleado));
            //return output;

            var result = Business.Data.TraeListaEmpleado(numeroEmpleado);
            return result;
        }

        [WebMethod]
        public List<Entity.EventosEntity> TraeLitaEventos()
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string output = jss.Serialize(Business.Data.TraeLitaEventos());
            //return output;

            var result = Business.Data.TraeLitaEventos();
            return result;
        }

        [WebMethod]
        public List<Entity.DirectorioEntity> TraeListaDirectorio()
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string output = jss.Serialize(Business.Data.TraeListaDirectorio());
            //return output;

            var result = Business.Data.TraeListaDirectorio();
            return result;
        }

        [WebMethod]
        public List<Entity.VacacionesEntity> TraeVacaciones(String numeroEmpleado)
        {
            //JavaScriptSerializer jss = new JavaScriptSerializer();
            //string output = jss.Serialize(Business.Data.TraeListaVacaciones(numeroEmpleado));
            //return output;

            var result = Business.Data.TraeListaVacaciones(numeroEmpleado);
            return result;
        }

    }
}
