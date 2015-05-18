using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TenekRH.Services.Entity
{
    public class UsuarioEntity
    {
        public string Usuario
        {
            get;
            set;
        }
        public string Contrasena
        {
            get;
            set;
        }
        public int? NumeroUsuario
        {
            get;
            set;
        }
        public Boolean? Activo
        {
            get;
            set;
        }
    }
}