using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TenekRH.Services.Business
{
    public static class Data
    {
        public static string Login(string username, string password)
        {
            String numeroEmpleado = "0";
            try
            {
                using (var DB = new RHTenekEntities())
                {
                    List<Usuario> lUser = (from u in DB.Usuario
                                           where u.Usuario1 == username && u.Contrasena == password
                                           select u).ToList();
                    if (lUser.Count > 0)
                    {
                        numeroEmpleado = lUser.First().NumeroEmpleado.ToString();
                    }
                }
            }
            catch (Exception ex) { }
            return numeroEmpleado;
        }

        public static List<Entity.NominaEntity> TraeListaNomina(string numeroEmpleado)
        {
            List<Entity.NominaEntity> nomEntity = new List<Entity.NominaEntity>();
            try
            {
                int numEmpleado = 0;
                int.TryParse(numeroEmpleado, out numEmpleado);

                using (var DB = new RHTenekEntities())
                {
                    nomEntity = (from n in DB.Nomina
                                 where n.NumeroEmpleado == numEmpleado
                                 select n).ToList().Select(c =>
                                 new Entity.NominaEntity
                                 {
                                     Percepciones = c.Percepciones,
                                     Retenciones = c.Retenciones,
                                     Total = c.Total,
                                     NumeroEmpleado = c.NumeroEmpleado,
                                     periodo = c.Periodo.Value.ToShortDateString()
                                 }).ToList();
                }
            }
            catch (Exception ex)
            {
            }
            return nomEntity;
        }

        public static List<Entity.EmpleadoEntity> TraeListaEmpleado(string numeroEmpleado)
        {
            List<Entity.EmpleadoEntity> empEntity = new List<Entity.EmpleadoEntity>();
            try
            {
                int numEmpleado = 0;
                int.TryParse(numeroEmpleado, out numEmpleado);

                using (var DB = new RHTenekEntities())
                {
                    empEntity = (from e in DB.Empleado
                                 where e.NumeroEmpleado == numEmpleado
                                 join p in DB.Puesto on e.PuestoId equals p.PuestoId
                                 join per in DB.Perfil on e.PerfilId equals per.PerfilId
                                 select new Entity.EmpleadoEntity
                                 {
                                     NumeroEmpleado = e.NumeroEmpleado,
                                     ApellidosEmpleado = e.ApellidosEmpleado,
                                     NombresEmpleado = e.NombresEmpleado,
                                     dFechaNacimiento = e.FechaNacimiento,
                                     Direccion = e.Direccion,
                                     Correo = e.Correo,
                                     Telefono = e.Telefono,
                                     Mensajeria = e.IdMensajeria,
                                     Puesto = p.Descripcion,
                                     Perfil = per.Descripcion
                                 }).ToList().Select(
                                 c => new Entity.EmpleadoEntity
                                 {
                                     NumeroEmpleado = c.NumeroEmpleado,
                                     ApellidosEmpleado = c.ApellidosEmpleado,
                                     NombresEmpleado = c.NombresEmpleado,
                                     FechaNacimiento = c.dFechaNacimiento.ToShortDateString(),
                                     Direccion = c.Direccion,
                                     Correo = c.Correo,
                                     Telefono = c.Telefono,
                                     Mensajeria = c.Mensajeria,
                                     Puesto = c.Puesto,
                                     Perfil = c.Perfil
                                 }).ToList();

                }
            }
            catch (Exception ex) { }
            return empEntity;
        }

        public static List<Entity.EventosEntity> TraeLitaEventos()
        {
            List<Entity.EventosEntity> evEntity = new List<Entity.EventosEntity>();
            try
            {
                using (var DB = new RHTenekEntities())
                {
                    evEntity = (from e in DB.Eventos select e).ToList()
                            .Select(c => new Entity.EventosEntity
                                    {
                                        Descripcion = c.Descripcion,
                                        FechaInicio = c.FechaInicio.ToShortDateString(),
                                        FechaFin = c.FechaFin.ToShortDateString()
                                    }).ToList();
                }
            }
            catch (Exception ex) { }
            return evEntity;
        }

        public static List<Entity.DirectorioEntity> TraeListaDirectorio()
        {
            List<Entity.DirectorioEntity> listaDir = new List<Entity.DirectorioEntity>();
            try
            {
                using (var DB = new RHTenekEntities())
                {
                    listaDir = (from e in DB.Directorio
                                select new Entity.DirectorioEntity
                                {
                                    NombreDepartamento = e.NombreDepto,
                                    JefeDepartamento = e.JefeDepto,
                                    TelefonoDepartamento = e.TelefonoDepto,
                                    CorreoDepartamento = e.CorreoDepto
                                }).ToList();
                }
            }
            catch (Exception ex) { }
            return listaDir;
        }

        public static List<Entity.VacacionesEntity> TraeListaVacaciones(string numeroEmpleado)
        {
            List<Entity.VacacionesEntity> vacEntity = new List<Entity.VacacionesEntity>();
            try
            {
                int numEmpleado = 0;
                int.TryParse(numeroEmpleado, out numEmpleado);

                using (var DB = new RHTenekEntities())
                {
                    vacEntity = (from e in DB.Vacaciones
                                 where e.NumeroEmpleado == numEmpleado
                                 select new Entity.VacacionesEntity
                                 {
                                     NumeroEmpleado = e.NumeroEmpleado,
                                     Periodo = e.Periodo,
                                     DiasCorrespondientes = e.DiasCorrespondientes,
                                     DiasDisfrutados = e.DiasDisfrutados,
                                     DiasDisponibles = e.DiasDisponibles,
                                     PorcentajePrima = e.PorcentPrimaVacacional,
                                     Vencimiento = e.Vencimiento
                                 }).ToList();
                }
            }
            catch (Exception ex) { }
            return vacEntity;
        }
    }
}