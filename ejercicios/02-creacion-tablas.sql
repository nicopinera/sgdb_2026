create table empleado(
	nro_legajo int auto_increment primary key,
    dni int not null,
    cuil int not null,
    domicilio varchar(30),
    fechaNacimiento date,
    fechaIngreso date,
    fechaBaja date,
    sueldoBruto decimal,
    idJefe int,
    foreign key(idJefe) references empleado(nro_legajo)
    on delete restrict
    on update restrict
);

create table recibo(
	idRecibo int auto_increment primary key,
	fechaPago date,
	periodoAbonado int,
    diasTrabajados int,
    idEmpleado int,
    idItem int,
    foreign key(idEmpleado) references empleado(nro_legajo)
    on delete restrict
    on update restrict,
    foreign key(idItem) references item(idCodigo)
    on delete restrict
    on update restrict  
);

create table item(
	idCodigo int primary key,
    monto int,
    observacion varchar(30),
    foreign key(idCodigo) references codigo(idCodigo)
    on delete restrict
    on update restrict
);

create table codigo(
	idCodigo int primary key,
    descripcion varchar(30)
);

create table departamento(
	idDepartamento int auto_increment primary key,
    descripcion varchar(30)
);

create table historicoEmpDep(
	idDepartamento int,
    idEmpleado int,
    fechaDesde date,
    fechaHasta date,
    primary key(idDepartamento,idEmpleado),
    foreign key(idDepartamento) references departamento(idDepartamento),
    foreign key(idEmpleado) references empleado(nro_legajo)
);