﻿//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TenekRH.BusinessObjects
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class RHTenekEntities : DbContext
    {
        public RHTenekEntities()
            : base("name=RHTenekEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public DbSet<Directorio> Directorio { get; set; }
        public DbSet<Empleado> Empleado { get; set; }
        public DbSet<Eventos> Eventos { get; set; }
        public DbSet<Nomina> Nomina { get; set; }
        public DbSet<Perfil> Perfil { get; set; }
        public DbSet<Puesto> Puesto { get; set; }
        public DbSet<sysdiagrams> sysdiagrams { get; set; }
        public DbSet<Usuario> Usuario { get; set; }
        public DbSet<Vacaciones> Vacaciones { get; set; }
    }
}
