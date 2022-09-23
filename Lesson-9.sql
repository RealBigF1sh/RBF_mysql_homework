USE shop;

/* Практическое задание по теме “Транзакции, переменные, представления”*/

/*1 В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
транзакции.*/

START TRANSACTION;

SELECT * FROM users WHERE id = 1;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;

DELETE FROM users WHERE id = 1; -- Если переместить, то удаляем из 

COMMIT;


/*2 Создайте представление, которое выводит название name товарной позиции из таблицы
products и соответствующее название каталога name из таблицы catalogs. */

CREATE VIEW prod (name, heading)
  AS SELECT name, (SELECT name FROM catalogs WHERE catalogs.id = products.catalog_id)
    FROM products;

SELECT * FROM prod;


/* Практическое задание по теме “Администрирование MySQL” */

/* 1 Создайте двух пользователей которые имеют доступ к базе данных shop. Первому
пользователю shop_read должны быть доступны только запросы на чтение данных, второму
пользователю shop — любые операции в пределах базы данных shop. */

CREATE USER shop_read;

CREATE USER shop;

GRANT SELECT ON shop.* to shop_read;

GRANT ALL ON shop.* to shop;

/* Практическое задание по теме “Хранимые процедуры и функции, триггеры" */

/*1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от
текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с
12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый
вечер", с 00:00 до 6:00 — "Доброй ночи".*/

SELECT @hour := HOUR(NOW());

DELIMITER -

DROP FUNCTION IF EXISTS hello-
CREATE FUNCTION hello (hour INT)
RETURNS TEXT
BEGIN
  IF 6<=hour<12 THEN
    RETURN 'Доброе утро';
  ELSEIF 12 <= hour < 18 THEN
    RETURN 'Добрый день';
  ELSEIF 18 <= hour < 24 THEN
    RETURN 'Добрый вечер';
  ELSE 
    RETURN 'Доброй ночи';
  END IF;
END-


DROP FUNCTION IF EXISTS hello1-
CREATE FUNCTION hello1 ()
RETURNS TEXT
BEGIN
  IF 6<= HOUR(NOW()) <12 THEN
    RETURN 'Доброе утро';
  ELSEIF (HOUR(NOW()) >= 12 AND HOUR(NOW()) < 18) THEN
    RETURN 'Добрый день';
  ELSEIF (HOUR(NOW()) >= 18 AND HOUR(NOW()) < 24) THEN
    RETURN 'Добрый вечер';
  ELSE 
    RETURN 'Доброй ночи';
  END IF;
END-

DELIMITER ;

SELECT hello1;

SELECT hello(@hour);