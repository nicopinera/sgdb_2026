
-- Traer todos los datos
select * from persona;

-- Traer datos especificos
select * from persona where apellido = 'piñera';

-- Actualizar datos
update persona set apellido = 'bustamante' where dni = 12345;

-- Eliminar datos
delete from persona where dni = 134523421;

-- Insertar datos
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (44195541,'nicolas','piñera','3516871744','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (123,'juan','piñera','3516871744','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (324,'juan','piñera','3516871744','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (12345,'juan','battigane','3516871744','nicoElCapto@gmail.com','miCasa');
insert into persona (dni,nombre,apellido,telefono,email,domicilioActual) values (134523421,'juan','battigane','3516871744','nicoElCapto@gmail.com','miCasa');