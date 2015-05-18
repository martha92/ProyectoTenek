using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TenekRH.Services.Entity
{
    public class VacacionesEntity
    {
        public int? NumeroEmpleado
        {
            get;
            set;
        }
        public int Periodo
        {
            get;
            set;
        }
        public int DiasCorrespondientes
        {
            get;
            set;
        }
        public int DiasDisponibles
        {
            get;
            set;
        }
        public int DiasDisfrutados
        {
            get;
            set;
        }
        public decimal PorcentajePrima
        {
            get;
            set;
        }
        public int Vencimiento
        {
            get;
            set;
        }
    }
}