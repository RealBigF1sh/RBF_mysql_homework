USE shop;

-- Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем. --

INSERT users SET created_at = NOW(), updated_at = NOW());


/* Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.*/

ALTER TABLE 
  users 
MODIFY 
  created_at DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
  
/* В таблице складских запасов storehouses_products в поле value могут встречаться самые
разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех
записей.*/

INSERT INTO storehouses_products (value) VALUES 
    (0),
    (2500),
    (0),
    (30),
    (500),
    (1);

SELECT * FROM storehouses_products ORDER BY CASE WHEN value = 0 THEN TRUE ELSE FALSE END, value;

/* Из таблицы users необходимо извлечь пользователей, родившихся в августе и
мае. Месяцы заданы в виде списка английских названий ('may', 'august')*/

SELECT
  name, MONTHNAME(birthday_at) birthday_month 
FROM 
  users 
WHERE 
  MONTHNAME(birthday_at) = 'May' 
OR 
  MONTHNAME(birthday_at) = 'August';
 

/*Подсчитайте средний возраст пользователей в таблице users*/
 
 SELECT AVG(TIMESTAMPDIFF(YEAR , birthday_at, NOW())) AS 'Средний возраст пользователей' FROM users;

/* Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.
Следует учесть, что необходимы дни недели текущего года, а не года рождения.*/

SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS `day`, COUNT(*) AS `number` FROM users GROUP BY day ORDER BY `number` DESC;