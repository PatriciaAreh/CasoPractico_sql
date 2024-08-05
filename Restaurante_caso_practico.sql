/*b) Explorar la tabla “menu_items” para conocer los productos del menú.
1.- Realizar consultas para contestar las siguientes preguntas:
● Encontrar el número de artículos en el menú.*/
select * from menu_items;
--or
select count (menu_item_id)
from menu_items;
--Answer: 32 Items
--● ¿Cuál es el artículo menos caro y el más caro en el menú?

select item_name, price
from menu_items
order by 2 desc;

--Answer: más caro:Shrimp Scampi, price: 19.95, menos caro: Edamame, price 5.00

--● ¿Cuántos platos americanos hay en el menú?
Select count(category)
from menu_items
where category='American';

--Answer: 6

--¿Cuál es el precio promedio de los platos?
Select round(avg(price),2)
from menu_items;

--Answer 13.29

/*c) Explorar la tabla “order_details” para conocer los datos que han sido recolectados. 
1.- Realizar consultas para contestar las siguientes preguntas:
● ¿Cuántos pedidos únicos se realizaron en total?*/
select * from order_details;

select count (distinct order_id)
from order_details;

--Answer 5370

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?
Select order_id, count(item_id) 
	from order_details
	group by order_id
order by count(item_id) desc
limit 5;

--Answer 440,2675,3473,4305,443

--● ¿Cuándo se realizó el primer pedido y el último pedido?
Select order_date, order_time, order_id
from order_details
order by 1 desc;

Select order_date, order_time, order_id
from order_details
order by 1 asc;

--Answer: Primer pedido 2023-03-31 11:22 order 5309
--Ultimo pedido 2023-01-01 11:38 order 1

--● ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

Select order_date, order_details_id
From Order_details
where order_date between '2023-01-01'and'2023-01-05';

--Answer: 702 pedidos

/*d) Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
1.- Realizar un left join entre entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).*/
Select * from menu_items as m
left join order_details as o 
on m.menu_item_id =o.item_id;

/*e) Una vez que hayas explorado los datos en las tablas correspondientes y respondido las preguntas planteadas, 
realiza un análisis adicional utilizando este join entre las tablas. 
El objetivo es identificar 5 puntos clave que puedan ser de utilidad para los dueños del restaurante en el lanzamiento de su nuevo menú. 
Para ello, crea tus propias consultas y utiliza los resultados obtenidos para llegar a estas conclusiones.*/

-- 1.-en que fecha fue la venta con mayor ingreso y en cual fue con la de menor ingreso
Select order_date, sum (price) as "Total"
from order_details as o
left join menu_items as m 
on m.menu_item_id =o.item_id
group by order_date
order by "Total" desc
limit 1; 

Select order_date, sum (price) as "Total"
from menu_items as m
left join  order_details as o
on m.menu_item_id =o.item_id
group by order_date
order by "Total" asc
limit 1; 
--Answer: "2023-02-01" se vendío más con un total de $2396.35 y el día que se obtuvo la menor venta fue "2023-03-22" con un total de $1016.9

--2.-que categoria de comida fue la más vendida y la menos vendida en esas fechas 
Select count(o.order_details_id) as "Numero de ordenes", m.category, o.order_date
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 3,2
having o.order_date = '2023-02-01' 
order by "Numero de ordenes" desc;
-- Answer: Categoría más vendida en esas fechas fue: Asiatica y la menos vendida fue la italiana

Select count(o.order_details_id) as "Numero de ordenes", m.category, o.order_date
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 3,2
having o.order_date = '2023-03-22' 
order by "Numero de ordenes" desc;
--Answer: Categoría más venddida fue Asiatica y la menos fue la Americana

--3.-y en general cual es la que mas se vende
Select count(o.order_details_id) as "Numero de ordenes", m.category
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 2
order by "Numero de ordenes" desc;
--Answer: La categoría que más se vende es la asiatica y la menos Americana

--4.-cual fue el platillo que tuvo más pedidos
Select count(o.order_details_id) as "Numero de ordenes", m.item_name, category
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 2,3
order by "Numero de ordenes" desc;
-- Answer: El platillo que mas se pide regularmente son las hamburguesas, sin embargo los siguientes más pedidos pertenecen a la categoria Asiatica

--5.-entre cada categoria cuales son los 2 platillos mas pedidos
Select count(o.order_details_id) as "Numero de ordenes", m.item_name, m.category
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 2,3
	Having m.category= 'Asian'
order by "Numero de ordenes" desc
limit 2;
--Answer: 620	"Edamame" y 588	"Korean Beef Bowl"

Select count(o.order_details_id) as "Numero de ordenes", m.item_name, m.category
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 2,3
	Having m.category= 'Mexican'
order by "Numero de ordenes" desc
limit 2;
--Answer: 489	"Steak Torta" y 461	"Chips & Salsa"

Select count(o.order_details_id) as "Numero de ordenes", m.item_name, m.category
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 2,3
	Having m.category= 'Italian'
order by "Numero de ordenes" desc
limit 2;
--Answer: 470	"Spaghetti & Meatballs" y 420	"Eggplant Parmesan"

Select count(o.order_details_id) as "Numero de ordenes", m.item_name, m.category
from menu_items as m
join  order_details as o
on m.menu_item_id =o.item_id
group by 2,3
	Having m.category= 'American'
order by "Numero de ordenes" desc
limit 2;
--Answer: 622	"Hamburger" y 583	"Cheeseburger"

--6.- Cuales son los platillos más caros
Select item_name, category, price
from menu_items
group by 1,2,3
order by price desc;

/* Observando los datos dados tanto en las fechas en la que hubo más ingresos y en la de menos ingresos como en general, los platillos más 
vendidos son los asiaticos, sin importar que forman parte de los platillos más costosos del menu. 
Se puede observar que uno de los platillos más vendidos con un presio medio es la hamburguesa. Aún así la comida 
asíatica sigue siendo una de las preferidas por los clientes. Por lo que esos platillos por el momento deberian seguir
dentro del menú.
Por otro lado los demás platillos no tienen tanta presencia entre la preferencia de los clientes, por lo que se puede
sugerir un cambio en esos platillos, ya sea quitando algunos, como los menos pedidos y poner a prueba platillos 
nuevos.*/