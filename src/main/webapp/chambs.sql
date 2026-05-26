CREATE DATABASE chambs;
USE chambs;
CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    paterno VARCHAR(80) NOT NULL,
    materno VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    contrasena VARCHAR(50) NOT NULL,
    rol ENUM('medico', 'paciente') NOT NULL,
    fecha_nac DATE
);
CREATE TABLE medico (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    cedula VARCHAR(50),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);
CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    id_medico INT NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);
CREATE TABLE tipo_cita (
    id_tipo_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE CASCADE
);
CREATE TABLE cita (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    id_paciente INT NOT NULL,
    id_tipo_cita INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    notas TEXT,
    estado ENUM('programada', 'completada', 'cancelada') NOT NULL DEFAULT 'programada',
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_tipo_cita) REFERENCES tipo_cita(id_tipo_cita)
);
SET GLOBAL event_scheduler = ON;
CREATE EVENT actualizar_estado_citas ON SCHEDULE EVERY 1 MINUTE DO
UPDATE cita
SET estado = 'completada'
WHERE estado = 'programada'
    AND DATE_ADD(fecha_hora, INTERVAL 60 MINUTE) <= NOW();
CREATE TRIGGER after_cita_update
AFTER
UPDATE ON cita FOR EACH ROW BEGIN IF NEW.estado IN ('completada', 'cancelada') THEN
UPDATE historial
SET notas_medico = CONCAT(
        IFNULL(notas_medico, ''),
        ' | Estado: ',
        NEW.estado
    )
WHERE id_cita = NEW.id_cita;
END IF;
END;
CREATE TABLE tratamiento (
    id_tratamiento INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    precio INT,
    descripcion TEXT NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE CASCADE
);
CREATE TABLE paciente_tratamiento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_tratamiento INT NOT NULL,
    id_medico INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    observaciones TEXT,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico)
);
CREATE TABLE historial (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    id_cita INT,
    id_tratamiento INT,
    notas_medico TEXT,
    registrado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico),
    FOREIGN KEY (id_cita) REFERENCES cita(id_cita) ON DELETE
    SET NULL,
        FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento) ON DELETE
    SET NULL
);
CREATE TABLE insumo (
    id_insumo INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    cantidad_actual INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_medico) REFERENCES medico(id_medico) ON DELETE CASCADE
);