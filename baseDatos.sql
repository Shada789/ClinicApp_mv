create database chambs;
use chambs;
/* Crea las tablas segun el orden de los numeros */


/*Usuario    2*/
create table usuario(
id_usuario int AUTO_INCREMENT PRIMARY KEY,
contraseña int,
nombre VARCHAR(50)NOT NULL,
gmail VARCHAR(50)NOT NULL,
id_tipo int,
FOREIGN KEY (id_tipo) REFERENCES usuarioTipo(id_tipo)
);

/*Tipo de usuario    1*/
create table usuarioTipo(
id_tipo int AUTO_INCREMENT PRIMARY KEY,
tipo VARCHAR(50)NOT NULL
);


/*Medico     6*/
create table medico(
id_medico int AUTO_INCREMENT PRIMARY KEY,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

/*Cliente     7*/
create table cliente(
id_cliente int AUTO_INCREMENT PRIMARY KEY,
id_usuario int,
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);


/*Información del Medico     8*/
create table infoMedico(
id_infoMed int AUTO_INCREMENT PRIMARY KEY,
id_tratamiento int,
FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento),
id_cita int,
FOREIGN KEY (id_cita) REFERENCES citas(id_cita),
id_cliente int,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
id_medico int,
FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);
 
/*Información del Cliente     9*/
create table infoCliente(
id_infoCli int AUTO_INCREMENT PRIMARY KEY,
id_medico int,
FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
id_historial int,
FOREIGN KEY (id_historial) REFERENCES historial(id_historial),
id_cliente int,
FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


/*Tratamientos     3*/
create table tratamientos(
id_tratamiento int AUTO_INCREMENT PRIMARY KEY,
descripcion VARCHAR(50)NOT NULL,
precio int
);

/*Citas      4*/
create table citas(
id_cita int AUTO_INCREMENT PRIMARY KEY,
fecha VARCHAR(20)NOT NULL,
hora VARCHAR(5)NOT NULL
);

/*Historial      5*/
create table historial(
id_historial int AUTO_INCREMENT PRIMARY KEY,
id_tratamiento int,
FOREIGN KEY (id_tratamiento) REFERENCES tratamientos(id_tratamiento),
id_cita int,
FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);
