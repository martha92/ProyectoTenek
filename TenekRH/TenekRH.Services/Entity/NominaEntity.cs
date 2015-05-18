using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TenekRH.Services.Entity
{
    public class NominaEntity
    {
        public decimal Percepciones
        {
            get;
            set;
        }
        public decimal Retenciones
        {
            get;
            set;
        }
        public decimal Total
        {
            get;
            set;
        }
        public int NumeroEmpleado
        {
            get;
            set;
        }

        public String periodo
        {
            get;
            set;
        }
    }
}