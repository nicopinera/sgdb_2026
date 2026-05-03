
-- Traer todos los datos
select * from persona;

-- Traer datos especificos
select * from persona where apellido = 'piñera';

-- Actualizar datos
update persona set apellido = 'bustamante' where dni = 1;

-- Eliminar datos
delete from persona where dni = 2;

-- Insertar datos
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (1,'nicolas','piñera','1','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (2,'juan','piñera','2','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (3,'juan','piñera','3','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (4,'juan','battigane','4','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (5,'juan','battigane','5','nicoElCapto@gmail.com','miCasa');