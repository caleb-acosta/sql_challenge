create table sales(
	id INT NOT null PRIMARY KEY,
   -- Creo una referencia a la tabla de clientes
	client_id INT NOT NULL REFERENCES users (id),
   -- Se crea una referencia a la tabla Proucto
	product_id INT NOT NULL REFERENCES products (id),
   -- Cantidad de prdocuto requerido
	quantity INT NOT NULL 
);