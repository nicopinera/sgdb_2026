delimiter //
create procedure check_stock  (in f_id int,in st_id int)
begin
	declare cantidadF int;
    set cantidadF = 0;
	select count(*) into cantidadF from inventory where film_id = f_id and store_id = st_id;
    if cantidadF = 0
		then SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Película no encontrada en esta tienda.';
	else
		select cantidadF;
    end if;
end
//
delimiter ;

select * from store;
select distinct film_id from film where film_id not in (select film_id from inventory);

select * from inventory where film_id=14;

call check_stock(13,2);