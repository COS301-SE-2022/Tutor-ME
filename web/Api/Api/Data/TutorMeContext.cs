﻿using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Api.Models;

namespace Api.Data
{
    public partial class TutorMeContext : DbContext
    {
        public TutorMeContext()
        {
        }

        public TutorMeContext(DbContextOptions<TutorMeContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Module> Modules { get; set; }
        public virtual DbSet<Tutee> Tutees { get; set; }
        public virtual DbSet<Tutor> Tutors { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Module>(entity =>
            {
                entity.HasKey(e => e.Code)
                    .HasName("PK__Modules__357D4CF84F643888");

                entity.Property(e => e.Code)
                    .HasMaxLength(800)
                    .IsUnicode(false)
                    .HasColumnName("code");

                entity.Property(e => e.ModuleName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("moduleName");
            });

            modelBuilder.Entity<Tutee>(entity =>
            {
                entity.ToTable("Tutee");

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .HasDefaultValueSql("(newid())");

                entity.Property(e => e.Age)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasColumnName("age");

                entity.Property(e => e.Bio)
                    .IsUnicode(false)
                    .HasColumnName("bio");

                entity.Property(e => e.Connections)
                    .IsUnicode(false)
                    .HasColumnName("connections");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("email");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("firstName");

                entity.Property(e => e.Gender)
                    .IsRequired()
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .HasColumnName("gender");

                entity.Property(e => e.Institution)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("institution");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("lastName");

                entity.Property(e => e.Location)
                    .IsUnicode(false)
                    .HasColumnName("location");

                entity.Property(e => e.Modules)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("modules");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("password");

                entity.Property(e => e.TutorsCode)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("tutorsCode");
            });

            modelBuilder.Entity<Tutor>(entity =>
            {
                entity.ToTable("Tutor");

                entity.Property(e => e.Id)
                    .HasColumnName("id")
                    .HasDefaultValueSql("(newid())");

                entity.Property(e => e.Age)
                    .IsRequired()
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasColumnName("age");

                entity.Property(e => e.Bio)
                    .IsUnicode(false)
                    .HasColumnName("bio");

                entity.Property(e => e.Connections)
                    .IsUnicode(false)
                    .HasColumnName("connections");

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("email");

                entity.Property(e => e.FirstName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("firstName");

                entity.Property(e => e.Gender)
                    .IsRequired()
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .HasColumnName("gender");

                entity.Property(e => e.Institution)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("institution");

                entity.Property(e => e.LastName)
                    .IsRequired()
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("lastName");

                entity.Property(e => e.Location)
                    .IsUnicode(false)
                    .HasColumnName("location");

                entity.Property(e => e.Modules)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("modules");

                entity.Property(e => e.Password)
                    .IsRequired()
                    .IsUnicode(false)
                    .HasColumnName("password");

                entity.Property(e => e.TuteesCode)
                    .IsUnicode(false)
                    .HasColumnName("tuteesCode");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
