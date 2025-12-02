create database chambs;
use chambs;
/* Crea las tablas segun el orden de los numeros */
/*Tipo de usuario    1*/
create table usuarioTipo (
    id_tipo int AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR (50) NOT NULL
);
INSERT INTO usuarioTipo (id_tipo, tipo)
VALUES (1, 'paciente'),
    (2, 'medico');
/*Usuario    2*/
create table usuario (
    id_usuario int AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL,
    paterno varchar (50) NOT NULL,
    materno varchar (50) NOT NULL,
    gmail varchar (50) NOT NULL,
    usuario varchar (50) not null,
    contrasena varchar (50) not null,
    cedula varchar (50),
    fechaNac date,
    id_tipo int,
    FOREIGN KEY (id_tipo) REFERENCES usuarioTipo (id_tipo)
);
/*Tratamientos     3*/
create table tratamientos (
    id_tratamiento int AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR (50) NOT NULL,
    precio int,
    descripcion text NOT NULL
);
/*Citas      4*/
create table citas (
    id_cita int AUTO_INCREMENT PRIMARY KEY,
    fecha_hora datetime (6) NOT NULL,
    nombre varchar(100) not null,
    tipo ENUM('consulta', 'control', 'urgencia') NOT NULL
);
/*Historial      5*/
create table historial (
    id_historial int AUTO_INCREMENT PRIMARY KEY,
    id_tratamiento int,
    id_cita int,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (id_tratamiento) REFERENCES tratamientos (id_tratamiento),
    FOREIGN KEY (id_cita) REFERENCES citas (id_cita)
);
/*Medico     6*/
create table medico (
    id_medico int AUTO_INCREMENT PRIMARY KEY,
    id_usuario int,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);
/*Cliente     7*/
create table cliente (
    id_cliente int AUTO_INCREMENT PRIMARY KEY,
    id_usuario int,
    FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)
);
/*Información del Medico     8*/
create table infoMedico (
    id_infoMed int AUTO_INCREMENT PRIMARY KEY,
    id_tratamiento int,
    FOREIGN KEY (id_tratamiento) REFERENCES tratamientos (id_tratamiento),
    id_cita int,
    FOREIGN KEY (id_cita) REFERENCES citas (id_cita),
    id_cliente int,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
    id_medico int,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico)
);
/*Información del Cliente     9*/
create table infoCliente (
    id_infoCli int AUTO_INCREMENT PRIMARY KEY,
    id_medico int,
    FOREIGN KEY (id_medico) REFERENCES medico (id_medico),
    id_historial int,
    FOREIGN KEY (id_historial) REFERENCES historial (id_historial),
    id_cliente int,
    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);