USE shop;

/* Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
интернет магазине.*/

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) -- 'Покупатели';

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_users_id(user_id)
) -- 'Заказы';

INSERT INTO
  orders (user_id)
VALUES
  (2),
  (5);
 
SELECT * FROM orders;

SELECT * FROM users;

SELECT 
  id, name 
FROM
  users
WHERE 
  id IN (SELECT user_id FROM orders);
  
/* Выведите список товаров products и разделов catalogs, который соответствует товару.*/
 
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела'
) -- 'Разделы интернет-магазина';

 
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description Text COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id(catalog_id)
) -- 'Товарные позиции';

SELECT * FROM catalogs;

SELECT * FROM products;

SELECT catalogs.name, products.name, products.description, products.price 
FROM 
  products AS products
JOIN
  catalogs AS catalogs
ON 
  products.catalog_id = catalogs.id;
 
/* Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
name). Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.*/

CREATE DATABASE Airport;

USE Airport;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  c_from VARCHAR(100),
  c_to VARCHAR(100)
) 

SELECT * FROM flights;

INSERT INTO
  flights (c_from, c_to)
VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 

DROP TABLE IF EXISTS sities;
CREATE TABLE sities (
  label VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100) COMMENT 'Город'
) 

INSERT INTO
  sities (label, name)
VALUES
  ('moscow', 'Москва'),
  ('novgorod', 'Новгород'),
  ('irkutsk', 'Иркутск'),
  ('omsk', 'Омск'),
  ('kazan', 'Казань');
  
SELECT 
  id, 
  (SELECT name FROM sities WHERE label = flights.c_from),
  (SELECT name FROM sities WHERE label = flights.c_to)
FROM 
  flights;