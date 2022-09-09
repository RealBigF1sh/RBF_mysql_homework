use vk;

-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем. --
SELECT 
  from_user_id AS user, to_user_id AS friend, COUNT(*) AS 'Количество сообщений' 
FROM 
  messages 
WHERE from_user_id = 15 
    OR to_user_id = 15
GROUP BY from_user_id, to_user_id LIMIT 1; 

-- Количество лайков для 10 самых молодых пользователей --
SELECT
  user_id AS 'Пользователь',
  (SELECT CONCAT (first_name, ' ', last_name) FROM users WHERE id = likes.user_id) AS 'Имя_Фамилия',
  (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE user_id = likes.user_id) AS 'Возраст',
  COUNT(*) AS 'Количество лайков'
FROM 
  likes
GROUP BY 
  user_id
ORDER BY 
  (SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE user_id = likes.user_id) LIMIT 10;

-- Кто больше лайкал: м или ж --
SELECT COUNT(*) AS likes, gender FROM likes, profiles
WHERE likes.user_id = profiles.user_id
GROUP BY gender;