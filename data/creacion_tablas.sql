-- Creacion Esquema/base de datos
create schema tp2;

-- Creacion tabla personas
create table persona (
	dni INT NOT NULL PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(45) NOT NULL,
    domicilioActual VARCHAR(30) NOT NULL
);

-- Creacion tabla afiliado
create table afiliado(
	nroAfiliado INT NOT NULL PRIMARY KEY auto_increment,
    dni INT NOT NULL,
    domicilioProcedencia VARCHAR(60),
    fechaIngreso datetime,
    anioCursando YEAR,
    estadoCivil enum('CASADO','SOLTERO','DIVORSIADO'),
    cantRifas INT NOT NULL,
    FOREIGN  KEY (dni) REFERENCES persona(dni)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- Creacion tabla comprador
create table comprador(
	idComprador INT NOT NULL primary KEY auto_increment,
    dni int not null,
    foreign key (dni) references persona(dni)
    on delete no action
    on update no action
);

-- Creacion tabla Rifa
create table rifa(
	numeroRifa int not null auto_increment primary key,
    serieRifa varchar(10) not null,
    nroAfiliado int not null,
    codSorteo int not null,
    foreign key (nroAfiliado) references afiliado(nroAfiliado)
    on delete no action
    on update no action,
    foreign key (codSorteo) references sorteo(codSorteo)
    on delete no action
    on update no action
);

-- Creacion tabla Sorteo
create table sorteo(
	codSorteo int not null auto_increment primary key,
    fechaInicio datetime not null,
    fechaFin datetime not null
);

-- Creacion tabla Grupo
create table grupo(
	idGrupo int not null auto_increment primary key,
    nombreGrupo varchar(45) not null,
    umbralRifaVendida int not null
);

-- Creacion tabla Historial_Gripo
create table historialGrupo(
	idHistorialGrupo int not null primary key auto_increment,
    nroAfiliado int not null,
    idGrupo int not null,
    anio year not null,
    foreign key (nroAfiliado) references afiliado(nroAfiliado)
    on delete no action
    on update no action,
    foreign key (idGrupo) references grupo(idGrupo)
    on delete no action
    on update no action
);

-- Creacion tabla Historial_Venta
create table historialVenta(
	idHistorialVenta int not null primary key auto_increment,
    idHistorialGrupo int not null,
    cantidadRifaVendida int not null,
    foreign key (idHistorialGrupo) references historialgrupo(idHistorialGrupo)
    on delete no action
    on update no action
);

-- Creacion tabla Coutas
create table couta(
	idCuota int not null auto_increment primary key,
    idInfoCuotas int not null,
    monto decimal not null,
    fechaPago datetime not null,
    pagada boolean not null,
    formaPago enum('efectivo','transferencia') not null,
    foreign key (idInfoCuotas) references infoCuotas(idInfoCuotas)
    on delete no action
    on update no action
);

-- Creacion tabla infoCoutas
create table infoCuotas(
	idInfoCuotas int not null primary key auto_increment,
    cantidadCuotas int not null,
    montoTotal decimal not null,
    idComprador int not null,
    numeroRifa int not null,
    foreign key (idComprador) references comprador(idComprador)
    on delete no action
    on update no action,
    foreign key (numeroRifa) references rifa(numeroRifa)
    on delete no action
    on update no action
);

-- Creacion tabla HistorialCompra
create table historialCompra(
	numeroRifa int not null primary key,
    idComprador int not null,
    fechaCompra datetime not null,
    foreign key (numeroRifa) references rifa(numeroRifa)
    on delete no action
    on update no action,
    foreign key (idComprador) references comprador(idComprador)
    on delete no action
    on update no action
);
