-- Creacion Esquema/base de datos
-- create schema tp2;

drop table if exists historialCompra;
drop table if exists couta;
drop table if exists infoCuotas;
drop table if exists historialVenta;
drop table if exists historialGrupo;
drop table if exists rifa;
drop table if exists comprador;
drop table if exists afiliado;
drop table if exists grupo;
drop table if exists sorteo;
drop table if exists persona;


-- Creacion tabla personas
CREATE TABLE IF NOT EXISTS persona (
    dni INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(45) NOT NULL,
    domicilioActual VARCHAR(30) NOT NULL
);

-- Creacion tabla Sorteo
CREATE TABLE IF NOT EXISTS sorteo (
    codSorteo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fechaInicio DATETIME NOT NULL,
    fechaFin DATETIME NOT NULL
);

-- Creacion tabla Grupo
CREATE TABLE IF NOT EXISTS grupo (
    idGrupo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombreGrupo VARCHAR(45) NOT NULL,
    umbralRifaVendida INT NOT NULL
);

-- Creacion tabla afiliado
CREATE TABLE IF NOT EXISTS afiliado (
    nroAfiliado INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dni INT NOT NULL,
    domicilioProcedencia VARCHAR(60),
    fechaIngreso DATETIME,
    anioCursando YEAR,
    estadoCivil ENUM('CASADO', 'SOLTERO', 'DIVORSIADO'),
    cantRifas INT NOT NULL,
    FOREIGN KEY (dni)
        REFERENCES persona (dni)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla comprador
CREATE TABLE IF NOT EXISTS comprador (
    idComprador INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    dni INT NOT NULL,
    FOREIGN KEY (dni)
        REFERENCES persona (dni)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla Rifa
CREATE TABLE IF NOT EXISTS rifa (
    numeroRifa INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    serieRifa VARCHAR(10) NOT NULL,
    nroAfiliado INT NOT NULL,
    codSorteo INT NOT NULL,
    FOREIGN KEY (nroAfiliado)
        REFERENCES afiliado (nroAfiliado)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (codSorteo)
        REFERENCES sorteo (codSorteo)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla Historial_Gripo
CREATE TABLE IF NOT EXISTS historialGrupo (
    idHistorialGrupo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nroAfiliado INT NOT NULL,
    idGrupo INT NOT NULL,
    anio YEAR NOT NULL,
    FOREIGN KEY (nroAfiliado)
        REFERENCES afiliado (nroAfiliado)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (idGrupo)
        REFERENCES grupo (idGrupo)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla Historial_Venta
CREATE TABLE IF NOT EXISTS historialVenta (
    idHistorialVenta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    idHistorialGrupo INT NOT NULL,
    cantidadRifaVendida INT NOT NULL,
    FOREIGN KEY (idHistorialGrupo)
        REFERENCES historialgrupo (idHistorialGrupo)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla infoCoutas
CREATE TABLE IF NOT EXISTS infoCuotas (
    idInfoCuotas INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cantidadCuotas INT NOT NULL,
    montoTotal DECIMAL NOT NULL,
    idComprador INT NOT NULL,
    numeroRifa INT NOT NULL,
    FOREIGN KEY (idComprador)
        REFERENCES comprador (idComprador)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (numeroRifa)
        REFERENCES rifa (numeroRifa)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla Coutas
CREATE TABLE IF NOT EXISTS couta (
    idCuota INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    idInfoCuotas INT NOT NULL,
    monto DECIMAL NOT NULL,
    fechaPago DATETIME NOT NULL,
    pagada BOOLEAN NOT NULL,
    formaPago ENUM('efectivo', 'transferencia') NOT NULL,
    FOREIGN KEY (idInfoCuotas)
        REFERENCES infoCuotas (idInfoCuotas)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- Creacion tabla HistorialCompra
CREATE TABLE IF NOT EXISTS historialCompra (
    numeroRifa INT NOT NULL PRIMARY KEY,
    idComprador INT NOT NULL,
    fechaCompra DATETIME NOT NULL,
    FOREIGN KEY (numeroRifa)
        REFERENCES rifa (numeroRifa)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (idComprador)
        REFERENCES comprador (idComprador)
        ON DELETE NO ACTION ON UPDATE NO ACTION
);
