#
# TABLE STRUCTURE FOR: communities
#

DROP TABLE IF EXISTS `communities`;

CREATE TABLE `communities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор сроки',
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название группы',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Группы';

#
# TABLE STRUCTURE FOR: communities_users
#

DROP TABLE IF EXISTS `communities_users`;

CREATE TABLE `communities_users` (
  `community_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на группу',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  PRIMARY KEY (`community_id`,`user_id`) COMMENT 'Составной первичный ключ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Участники групп, связь между пользователями и группами';

#
# TABLE STRUCTURE FOR: friendship
#

DROP TABLE IF EXISTS `friendship`;

CREATE TABLE `friendship` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
  `friend_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя приглашения дружить',
  `status_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на статус (текущее состояние) отношений',
  `requested_at` datetime DEFAULT current_timestamp() COMMENT 'Время отправления приглашения дружить',
  `confirmed_at` datetime DEFAULT NULL COMMENT 'Время подтверждения приглашения',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`user_id`,`friend_id`) COMMENT 'Составной первичный ключ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Таблица дружбы';

#
# TABLE STRUCTURE FOR: friendship_statuses
#

DROP TABLE IF EXISTS `friendship_statuses`;

CREATE TABLE `friendship_statuses` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название статуса',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Статусы дружбы';

#
# TABLE STRUCTURE FOR: media
#

DROP TABLE IF EXISTS `media`;

CREATE TABLE `media` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя, который загрузил файл',
  `filename` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Путь к файлу',
  `size` int(11) NOT NULL COMMENT 'Размер файла',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Метаданные файла' CHECK (json_valid(`metadata`)),
  `media_type_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на тип контента',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Медиафайлы';

#
# TABLE STRUCTURE FOR: media_types
#

DROP TABLE IF EXISTS `media_types`;

CREATE TABLE `media_types` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Название типа',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Типы медиафайлов';

#
# TABLE STRUCTURE FOR: messages
#

DROP TABLE IF EXISTS `messages`;

CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `from_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  `to_user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на получателя сообщения',
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Текст сообщения',
  `is_important` tinyint(1) DEFAULT NULL COMMENT 'Признак важности',
  `is_delivered` tinyint(1) DEFAULT NULL COMMENT 'Признак доставки',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Сообщения';

#
# TABLE STRUCTURE FOR: profiles
#

DROP TABLE IF EXISTS `profiles`;

CREATE TABLE `profiles` (
  `user_id` int(10) unsigned NOT NULL COMMENT 'Ссылка на пользователя',
  `gender` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Пол',
  `birthday` date DEFAULT NULL COMMENT 'Дата рождения',
  `photo_id` int(10) unsigned DEFAULT NULL COMMENT 'Ссылка на основную фотографию пользователя',
  `status` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Текущий статус',
  `city` varchar(130) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Город проживания',
  `country` varchar(130) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Страна проживания',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Профили';

INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (1, '', '1989-05-06', 427, 'Est dolorum cupiditate molesti', 'West Flossieside', '735', '2021-03-01 12:37:40', '1985-05-04 00:09:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (2, '', '1994-09-12', 734, 'Nisi quisquam enim suscipit ev', 'East Loycechester', '596153666', '1978-03-02 13:19:54', '1998-06-08 23:39:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (3, '', '1989-11-23', 140, 'Repudiandae culpa rerum volupt', 'East Brendenside', '690567653', '1977-01-24 08:50:15', '1975-01-20 04:58:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (4, '', '2020-09-16', 446, 'Tempora adipisci vero blanditi', 'New Salliefort', '39', '1990-11-13 02:22:47', '2015-07-08 15:02:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (5, '', '1999-03-06', 402, 'Inventore consequatur laborum ', 'South Lacyside', '44', '2013-01-03 06:30:38', '2011-01-18 16:39:52');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (6, '', '1999-10-16', 486, 'Dolores sed officia quas atque', 'Lake Lucius', '767651', '2016-10-31 02:12:55', '1985-10-31 15:20:16');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (7, '', '1993-04-01', 353, 'Impedit omnis nihil delectus i', 'Lake Audietown', '594237', '2015-01-15 00:57:02', '1978-01-21 13:09:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (8, '', '2008-06-19', 691, 'Vero voluptas eaque ea tempora', 'Schusterview', '2222', '1977-03-03 23:31:01', '1991-02-08 13:56:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (9, '', '2002-09-27', 790, 'Consequatur debitis optio laud', 'New Wilfredoshire', '488305565', '2004-10-29 17:09:01', '1992-10-28 23:11:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (10, '', '1973-03-30', 874, 'Tempore et dolores cumque duci', 'Kulashaven', '', '2001-06-20 20:06:18', '2001-12-22 20:03:21');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (11, '', '2015-02-10', 702, 'Eos quis quibusdam modi placea', 'New Amberchester', '57767', '2003-06-25 22:13:40', '1972-06-19 12:05:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (12, '', '1977-03-10', 77, 'Vel enim eligendi nobis sit no', 'West Minnieburgh', '11245049', '1973-08-14 02:33:20', '1987-05-21 03:06:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (13, '', '2016-07-20', 694, 'Dolor vero id sequi pariatur i', 'Orrinport', '861', '1997-10-24 07:27:22', '2014-03-25 00:30:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (14, '', '2017-07-11', 595, 'Incidunt voluptas ut magni dic', 'North Frederikfurt', '10', '2013-03-24 06:33:36', '1984-02-07 13:07:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (15, '', '1997-09-22', 722, 'Aliquam minus et sint enim. Es', 'Schambergerborough', '627577', '2012-08-07 12:34:36', '2003-05-15 08:26:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (16, '', '2013-11-24', 497, 'Rerum consequatur dignissimos ', 'Macejkovicstad', '3622883', '2014-12-19 05:27:02', '2000-01-21 18:10:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (17, '', '2018-10-26', 39, 'Pariatur et distinctio soluta.', 'South Eugenia', '45', '2013-02-16 02:48:48', '2009-09-14 02:33:18');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (18, '', '1975-11-24', 541, 'Cumque id magnam ipsam consequ', 'New Emanuelfurt', '391', '1980-04-29 08:37:38', '1990-05-13 21:37:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (19, '', '1974-09-14', 155, 'Magnam eum esse consequatur il', 'Sanfordport', '', '2017-06-17 14:11:08', '1998-01-10 02:15:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (20, '', '2018-06-30', 63, 'Nemo cum iusto autem sit id vo', 'Robertsborough', '49', '1971-12-16 23:26:20', '2011-09-25 12:09:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (21, '', '2010-09-08', 465, 'Quidem perspiciatis exercitati', 'Okunevaland', '9284', '2018-06-12 13:15:11', '2012-02-19 23:22:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (22, '', '2001-10-19', 758, 'Est consequatur consectetur de', 'East Jessyca', '5', '1990-01-17 17:32:50', '2003-01-08 07:27:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (23, '', '1993-10-02', 178, 'Porro vel nesciunt illo incidu', 'South Rosie', '243531', '1970-05-22 02:43:27', '1976-06-21 18:56:15');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (24, '', '1971-02-23', 667, 'Adipisci voluptate impedit cup', 'Cassintown', '', '2005-06-24 15:37:09', '1982-09-11 07:55:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (25, '', '1984-04-27', 808, 'Velit natus dolores consequunt', 'Norbertoshire', '1621671', '1981-12-24 15:01:48', '1985-09-08 14:54:32');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (26, '', '1976-09-15', 276, 'Dolores quisquam quas dolores ', 'South Laney', '422', '2013-06-29 04:47:02', '2008-06-01 00:35:29');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (27, '', '1984-03-22', 702, 'Explicabo et ratione aspernatu', 'Port Nolanview', '436155', '2020-02-21 01:37:40', '1980-10-15 17:21:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (28, '', '2000-01-19', 81, 'Consequatur alias nihil ipsam ', 'Stoltenbergville', '8550067', '2009-10-01 04:56:03', '2002-12-31 14:56:46');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (29, '', '2007-04-07', 234, 'Amet in ut recusandae qui. Ver', 'Torphyshire', '492149109', '1989-04-28 17:17:18', '2006-11-17 23:53:42');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (30, '', '1998-11-15', 997, 'Occaecati repellat rerum repel', 'Lake Millieview', '969364776', '1978-05-07 16:46:45', '2014-12-30 09:59:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (31, '', '1972-05-04', 118, 'Molestias et ullam quas molest', 'East Angusberg', '', '2020-07-07 07:08:15', '1975-06-08 17:29:05');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (32, '', '1971-11-16', 900, 'Impedit blanditiis veritatis q', 'Darrylchester', '29', '2011-02-22 13:51:56', '1989-01-13 15:23:04');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (33, '', '2020-04-03', 602, 'Quia tempore veritatis eveniet', 'Lysannestad', '83789093', '1971-08-15 16:14:16', '2011-10-05 07:06:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (34, '', '2003-03-27', 577, 'Quas et quos aut. Et possimus ', 'West Venamouth', '16481', '2013-09-13 04:23:37', '2018-01-21 01:52:59');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (35, '', '1985-01-14', 959, 'Et pariatur tenetur atque sunt', 'Port Nathanland', '77', '1993-02-25 10:14:22', '1979-02-02 08:38:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (36, '', '2005-05-25', 798, 'Et dolores facere quod quia. I', 'New Heberstad', '', '2020-12-20 16:26:52', '1989-05-27 20:04:03');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (37, '', '2015-02-15', 975, 'Officia est tenetur quasi earu', 'South Enaside', '241083', '1981-04-10 07:33:21', '2005-12-23 22:08:13');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (38, '', '1983-06-15', 821, 'Quae voluptates accusamus quo ', 'Cletusbury', '685091293', '2010-06-15 08:48:55', '1998-11-19 06:51:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (39, '', '1999-08-28', 126, 'Id excepturi non eum. Expedita', 'Caterinaville', '', '1970-01-15 11:24:40', '2015-09-30 16:19:41');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (40, '', '1972-03-22', 719, 'Sequi debitis quisquam maiores', 'Lake Jeffery', '21667218', '2000-10-08 10:38:54', '2014-11-17 05:50:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (41, '', '2021-04-29', 520, 'Repellendus perferendis adipis', 'South Erin', '42177', '1984-11-11 16:51:50', '1991-06-17 00:11:55');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (42, '', '2017-06-04', 761, 'Qui fugiat quia ut dignissimos', 'Jamilfurt', '89', '2014-05-05 03:10:30', '2012-10-15 20:30:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (43, '', '1985-09-12', 730, 'Et ut aspernatur ipsa quia inc', 'West Karlee', '352242648', '2006-12-08 21:54:43', '2003-07-14 12:33:12');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (44, '', '1999-05-16', 903, 'Hic aspernatur quisquam ut ven', 'Presleytown', '6508440', '1998-02-04 20:36:22', '2001-02-22 16:17:30');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (45, '', '1990-12-14', 212, 'Doloribus ad rerum recusandae ', 'Karellebury', '6634164', '2021-05-17 17:31:01', '1981-07-01 13:22:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (46, '', '2011-01-18', 242, 'Facere et et magnam sit sint q', 'North Francis', '892', '2018-10-02 20:07:14', '1993-11-13 12:09:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (47, '', '1996-11-03', 797, 'Consectetur temporibus molesti', 'New Carter', '1986734', '1979-06-09 13:02:32', '1995-12-04 19:54:07');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (48, '', '1991-11-20', 908, 'Et quibusdam culpa beatae sint', 'South Briceshire', '5397092', '1996-05-15 15:58:12', '2022-08-25 13:24:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (49, '', '2003-05-14', 166, 'Repudiandae voluptatem ipsum e', 'Jeanieburgh', '360', '1970-08-04 17:09:00', '1999-07-22 02:10:17');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (50, '', '2012-03-04', 561, 'Officiis sit asperiores quia p', 'New Clarahaven', '8', '2015-04-20 08:38:13', '2001-06-21 08:15:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (51, '', '2000-01-17', 201, 'Natus ipsa ut asperiores quae ', 'Othaport', '949460', '2013-09-25 12:08:46', '2007-09-28 00:24:06');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (52, '', '1996-05-29', 308, 'Aut in sint incidunt. Et elige', 'Dandreburgh', '', '1986-12-30 08:45:14', '2014-12-18 06:42:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (53, '', '2009-12-11', 173, 'Fugit rem consectetur nisi rer', 'Olaborough', '58782159', '2015-05-01 16:49:00', '1991-04-25 06:39:05');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (54, '', '1980-04-18', 903, 'Non aperiam fuga expedita duci', 'East Shanelle', '2753', '1980-03-27 22:53:01', '2008-07-10 16:42:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (55, '', '1993-05-31', 756, 'Nisi sit voluptatem qui sequi ', 'Wymanside', '760', '2002-06-10 09:10:36', '1985-06-02 13:33:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (56, '', '2019-11-18', 605, 'Eos est qui consequuntur dolor', 'Lake Oswaldo', '9', '2017-03-13 09:49:11', '2008-09-27 10:03:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (57, '', '2009-03-27', 256, 'Necessitatibus explicabo vero ', 'East Ashafort', '6594959', '2000-09-16 08:42:40', '1999-11-30 21:09:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (58, '', '2012-07-18', 269, 'Necessitatibus aut eligendi sa', 'Rohanmouth', '325', '1980-10-05 03:55:23', '2012-06-15 13:27:01');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (59, '', '2001-05-06', 961, 'Sed accusamus qui non consequu', 'Talonstad', '575227444', '1983-03-21 18:10:54', '1977-10-31 08:54:31');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (60, '', '2013-11-06', 582, 'Asperiores unde molestias eos ', 'South Kareem', '', '2016-04-14 23:38:14', '2004-04-27 14:48:24');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (61, '', '1981-06-14', 507, 'Provident commodi repudiandae ', 'West Kenya', '17', '2013-05-01 03:21:02', '2020-11-26 08:29:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (62, '', '1986-04-10', 503, 'Et fugit rem blanditiis. At ma', 'North Savannaview', '2', '2007-06-17 21:14:49', '1975-10-12 12:21:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (63, '', '1974-03-12', 379, 'Quia veniam non aliquam ea ab ', 'Martinabury', '89179926', '1982-11-22 06:20:53', '2015-05-21 19:28:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (64, '', '2017-10-25', 143, 'Officia ducimus eum quae omnis', 'Estellaberg', '85336455', '1979-01-10 14:39:14', '1976-09-30 05:37:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (65, '', '1972-11-28', 991, 'Omnis ad nihil quisquam qui ea', 'Mitchelbury', '9963', '1986-01-25 07:11:12', '1998-04-11 03:02:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (66, '', '2018-05-01', 848, 'Voluptas in quas praesentium v', 'Lefflerfort', '19280909', '1970-08-05 03:36:55', '1997-03-13 08:05:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (67, '', '1984-04-05', 38, 'Nihil delectus velit doloribus', 'Marielatown', '524652147', '1994-04-29 11:51:44', '2003-12-12 09:11:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (68, '', '2018-10-06', 725, 'Nostrum fugiat et adipisci opt', 'Port Chris', '4216', '1973-01-17 21:23:27', '2011-07-19 09:05:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (69, '', '2004-02-18', 711, 'Quisquam veritatis accusantium', 'North Gwendolynberg', '18199957', '1975-04-28 23:44:01', '1999-09-16 05:03:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (70, '', '2022-03-15', 366, 'Enim enim amet cumque mollitia', 'Diegoshire', '17154763', '1970-03-30 07:07:39', '1985-06-08 23:13:29');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (71, '', '1987-11-12', 481, 'Sequi dolorem exercitationem e', 'Angelinatown', '354', '1992-06-04 06:26:26', '1993-11-22 10:34:11');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (72, '', '1971-12-24', 664, 'Ea beatae sed provident offici', 'Port Gregoryfurt', '580', '2011-04-09 16:58:18', '2013-03-04 10:43:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (73, '', '1971-02-12', 467, 'Ea quasi qui nostrum aperiam v', 'Lake Lenny', '66118995', '1973-09-15 01:01:11', '1970-11-02 08:06:35');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (74, '', '2013-02-06', 366, 'Quia quibusdam vitae dicta ea ', 'New Marcelle', '', '1982-10-18 14:54:48', '1970-07-10 04:53:05');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (75, '', '1978-06-21', 278, 'Nesciunt ea esse autem deserun', 'Port Judy', '', '2005-03-06 11:14:19', '1993-07-07 10:07:22');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (76, '', '2004-09-06', 598, 'Velit non dolorem molestiae ip', 'Lake Morrisbury', '598', '1983-02-15 23:57:24', '1991-07-18 02:20:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (77, '', '1986-01-02', 52, 'Enim impedit quas placeat volu', 'Zaneshire', '59', '2006-05-29 22:26:49', '1973-05-10 06:49:51');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (78, '', '2000-09-14', 114, 'Dolore quia ea impedit. Sit au', 'West Lunaborough', '77954', '2016-12-14 08:55:47', '2018-05-18 08:11:09');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (79, '', '2016-06-20', 503, 'Sequi ex qui rem eos. Numquam ', 'Port Alvah', '940273989', '1978-04-08 19:28:29', '1999-06-08 15:26:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (80, '', '1977-08-13', 740, 'Amet dolor blanditiis quia eum', 'Port Belleberg', '357', '1986-07-25 04:40:58', '1999-11-04 21:22:49');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (81, '', '2000-12-26', 150, 'Qui corporis beatae magni natu', 'Huelfurt', '233', '1989-10-14 19:11:24', '1991-10-06 05:21:37');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (82, '', '1988-09-28', 876, 'In quia iste tempora est dolor', 'Waelchifurt', '', '2002-01-26 02:04:48', '2000-09-25 21:35:34');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (83, '', '2014-06-18', 773, 'Velit delectus et cupiditate q', 'Percivaltown', '114', '1984-07-05 20:32:35', '2015-09-04 23:48:10');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (84, '', '1976-10-20', 447, 'Laborum ut qui quaerat et dict', 'Kendrabury', '4056', '2003-06-29 21:11:48', '1978-10-22 17:08:26');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (85, '', '1993-04-05', 89, 'Minima ea sapiente aut et mini', 'Harriston', '5', '1995-12-10 02:46:55', '1989-07-30 07:42:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (86, '', '2005-03-16', 559, 'Autem nesciunt quia doloribus ', 'East Sigrid', '5540995', '1985-12-29 08:50:15', '2017-04-07 18:42:29');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (87, '', '2014-11-25', 646, 'Vero accusantium mollitia erro', 'Heaneyshire', '477341259', '1985-07-20 09:39:29', '1978-01-19 02:27:47');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (88, '', '1999-02-16', 662, 'Similique error sunt ea et dic', 'East Genesisfurt', '109276619', '2013-06-13 05:56:03', '2006-09-29 22:06:39');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (89, '', '1983-09-10', 437, 'Ab esse sint ipsum enim aut et', 'Shanabury', '142', '2004-08-28 22:19:17', '2000-08-06 23:59:48');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (90, '', '2012-04-13', 119, 'Molestiae dolores repudiandae ', 'North Micheal', '5190686', '1986-01-25 17:09:57', '1988-02-23 11:47:43');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (91, '', '1977-11-14', 345, 'Quis beatae et sequi aspernatu', 'Lake Mayemouth', '67158', '2007-07-13 01:35:47', '2003-10-20 01:39:33');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (92, '', '2011-06-01', 974, 'Et fuga sed molestiae placeat ', 'Port Hayley', '8476215', '2018-06-07 18:16:06', '2007-06-12 21:32:04');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (93, '', '1996-05-28', 974, 'Esse delectus voluptatem esse.', 'Lesleyside', '86834', '2020-01-04 04:01:00', '2000-03-17 23:20:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (94, '', '2013-07-30', 627, 'Veniam ut omnis molestias tota', 'Halvorsonshire', '762', '1971-11-09 11:44:38', '1985-03-24 12:32:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (95, '', '2009-06-13', 765, 'Culpa facere voluptatibus iust', 'Ernieport', '918103', '2013-08-22 11:22:08', '2013-01-22 11:07:23');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (96, '', '2008-07-27', 952, 'Et consequatur omnis natus exc', 'West Gregory', '2012', '1976-10-02 07:10:44', '1975-01-23 16:07:20');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (97, '', '1986-01-17', 975, 'Amet qui modi blanditiis repud', 'Jenkinsfurt', '437', '1978-11-06 03:57:53', '2003-07-24 02:19:36');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (98, '', '1981-02-16', 994, 'Dolores placeat sequi a. Et et', 'South Ludwigland', '3101', '1980-10-29 04:56:08', '1976-03-09 21:44:45');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (99, '', '1998-05-25', 274, 'Et iusto quia iste. Ipsam veri', 'Estelport', '1169425', '1995-11-29 00:28:11', '2004-04-29 09:06:27');
INSERT INTO `profiles` (`user_id`, `gender`, `birthday`, `photo_id`, `status`, `city`, `country`, `created_at`, `updated_at`) VALUES (100, '', '1990-06-22', 545, 'Quo nesciunt omnis nihil dolor', 'East Aron', '419327', '1986-10-07 11:44:03', '2001-01-12 00:40:36');


#
# TABLE STRUCTURE FOR: users
#

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Имя пользователя',
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Фамилия пользователя',
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Почта',
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Телефон',
  `created_at` datetime DEFAULT current_timestamp() COMMENT 'Время создания строки',
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Время обновления строки',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Пользователи';

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (1, 'Darius', 'Reilly', 'reynolds.cleta@example.com', '519-036-6695', '2006-08-24 20:00:34', '2018-02-21 17:06:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (2, 'Ali', 'Jast', 'amos50@example.com', '546.920.2558x8558', '2022-08-12 05:42:41', '2001-10-18 11:27:22');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (3, 'Talon', 'Beatty', 'brody60@example.net', '03661278695', '1980-06-24 03:37:46', '2007-01-04 04:39:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (4, 'Jewell', 'Sporer', 'mpredovic@example.net', '(505)589-0280x45536', '2018-05-22 18:25:03', '2004-08-29 15:18:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (5, 'Gardner', 'Balistreri', 'rebeka00@example.org', '1-099-032-8595x2624', '1986-04-06 11:43:01', '2015-07-05 10:09:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (6, 'Adriana', 'Bahringer', 'flavio.stracke@example.org', '876-517-8134x99901', '1992-12-04 03:34:21', '2007-04-20 22:53:05');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (7, 'Cristobal', 'Lesch', 'mueller.monroe@example.net', '519-446-9433', '2022-07-13 01:36:52', '2011-05-17 05:29:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (8, 'Elody', 'Hamill', 'armani.mueller@example.net', '1-777-980-5297', '1989-11-09 20:33:28', '2018-05-30 04:07:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (9, 'Eusebio', 'Beatty', 'omann@example.com', '1-146-610-8647x761', '2019-10-29 17:03:34', '2014-05-06 04:08:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (10, 'Sonia', 'Prosacco', 'alec.jaskolski@example.org', '869.213.2890', '1988-05-25 17:58:41', '2018-02-15 20:10:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (11, 'Patrick', 'Doyle', 'ignacio30@example.com', '(275)680-1383', '2013-08-26 20:11:43', '1976-12-16 18:05:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (12, 'Kira', 'Gaylord', 'hilpert.tito@example.net', '(125)225-7649', '2015-11-19 02:37:45', '2004-06-21 14:25:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (13, 'Albina', 'Glover', 'hziemann@example.com', '1-859-591-1390', '1998-08-14 01:16:16', '2021-11-22 15:19:26');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (14, 'Daren', 'Stroman', 'kschmidt@example.com', '987-585-6984', '1991-11-16 05:56:05', '1997-07-02 07:40:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (15, 'Bertha', 'Paucek', 'rasheed44@example.net', '562-515-6509x0963', '1989-04-24 23:02:50', '2003-02-12 10:21:28');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (16, 'Ashley', 'Feil', 'nweber@example.net', '1-709-104-9481', '1994-10-31 13:50:01', '2009-01-22 17:23:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (17, 'Ona', 'Roob', 'stone.wilkinson@example.net', '(977)996-9451', '2002-12-20 04:51:07', '1983-11-10 11:19:01');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (18, 'Dudley', 'Hane', 'mjerde@example.com', '01710981538', '2010-11-17 13:50:07', '1973-07-08 13:55:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (19, 'Quincy', 'Friesen', 'luigi55@example.com', '535-941-5166', '2006-03-11 07:55:10', '2001-11-15 20:51:50');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (20, 'Anne', 'Kautzer', 'elmer.kuphal@example.net', '05508934086', '1998-08-31 01:11:00', '2012-07-11 04:20:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (21, 'Jazmin', 'Bednar', 'art.pollich@example.org', '(453)019-0888x271', '1975-03-01 09:43:13', '1983-05-15 23:48:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (22, 'Georgiana', 'Roob', 'samara.dickinson@example.org', '1-265-801-5726x70736', '1988-03-25 03:05:42', '1979-07-18 04:25:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (23, 'Elisa', 'Friesen', 'aernser@example.com', '852.837.9797', '1981-08-30 17:46:11', '2008-09-22 12:59:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (24, 'Wendy', 'Haley', 'cole.estell@example.com', '1-617-956-1932', '2008-07-10 06:40:46', '2016-07-21 06:31:06');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (25, 'Emmitt', 'Hartmann', 'lmueller@example.net', '1-697-589-8904x989', '1974-01-14 12:33:34', '1976-10-20 10:54:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (26, 'Missouri', 'Leannon', 'dolson@example.com', '(169)232-3101', '1981-07-08 08:12:13', '1989-06-19 16:45:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (27, 'Hillary', 'Schumm', 'axel57@example.net', '013.828.9971', '2003-05-29 14:07:08', '1990-02-07 09:19:45');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (28, 'Irma', 'Nikolaus', 'yweimann@example.org', '196.794.2000x936', '1984-02-10 11:33:14', '1978-12-20 09:07:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (29, 'Elenor', 'Hilpert', 'troob@example.com', '464-709-5901x0390', '1977-11-18 04:47:52', '1999-01-11 00:43:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (30, 'Andres', 'Pacocha', 'hackett.ramiro@example.com', '1-926-514-3050x5714', '1990-01-12 16:18:15', '1988-09-26 23:05:30');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (31, 'Eden', 'Frami', 'lebsack.polly@example.net', '349-526-2379', '2014-10-02 04:44:36', '1994-10-11 23:00:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (32, 'Darrell', 'Eichmann', 'nicole.wilderman@example.net', '165.206.8157x128', '1999-11-23 07:41:08', '1975-12-23 11:12:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (33, 'Eloise', 'King', 'dorothea77@example.net', '000-976-6819x3153', '2002-02-09 10:26:52', '2014-05-18 12:32:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (34, 'Gianni', 'Langosh', 'haskell29@example.org', '808.553.9250x57898', '1977-09-24 20:00:08', '1994-08-08 14:30:31');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (35, 'Kali', 'Roob', 'fstreich@example.com', '1-930-889-8712x541', '1991-04-07 19:42:12', '2019-11-06 06:24:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (36, 'Esta', 'Terry', 'goodwin.jackeline@example.net', '842-753-8566x4594', '1973-10-24 02:28:17', '2019-07-04 14:56:25');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (37, 'Tyrell', 'Kautzer', 'doug.lesch@example.net', '02139810894', '2021-01-13 15:25:26', '1988-02-09 16:48:09');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (38, 'Fletcher', 'Larson', 'willy37@example.com', '00579931390', '1986-02-05 03:54:49', '2019-04-07 21:39:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (39, 'Dawn', 'Miller', 'donnelly.sigurd@example.com', '(224)942-6192x6470', '2020-11-25 01:05:11', '1970-04-29 05:07:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (40, 'Mossie', 'Gislason', 'qrunolfsdottir@example.com', '857-551-0335', '2007-02-19 09:09:06', '1982-04-11 22:24:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (41, 'Norbert', 'Wilkinson', 'lang.oleta@example.org', '1-806-931-6210', '1974-04-07 06:12:20', '1971-08-05 06:57:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (42, 'Aryanna', 'Feil', 'wdavis@example.net', '700.873.7808x6049', '2008-11-14 20:36:31', '2012-01-16 03:39:55');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (43, 'Letitia', 'Haag', 'aiyana16@example.com', '1-899-009-6318', '1977-12-03 20:37:46', '1976-08-10 14:18:24');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (44, 'Lisa', 'Dare', 'juliet88@example.net', '1-847-658-6085', '2003-07-11 01:17:18', '1970-04-26 09:36:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (45, 'Sasha', 'Towne', 'lfisher@example.org', '1-100-976-5186', '1975-01-08 10:07:37', '1974-04-04 10:47:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (46, 'Marcelina', 'Stroman', 'gulgowski.verner@example.com', '192.649.8350', '2014-07-09 22:17:24', '1999-02-02 20:23:35');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (47, 'Rod', 'Schiller', 'cbarrows@example.com', '862-108-5237', '1986-08-02 03:01:42', '1974-11-03 22:54:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (48, 'Kolby', 'Satterfield', 'terrill.friesen@example.org', '608-110-6394x643', '1976-04-16 01:54:46', '1975-08-03 01:46:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (49, 'Edna', 'Padberg', 'morgan.monahan@example.net', '583-783-3415', '2004-03-21 14:56:57', '2009-07-25 17:33:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (50, 'Deron', 'Douglas', 'shauck@example.org', '+27(9)6760689880', '2015-01-14 02:26:29', '1987-11-22 09:54:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (51, 'Jane', 'Jakubowski', 'nader.dante@example.net', '(624)813-1991x1240', '1993-10-27 23:11:00', '2015-10-24 01:19:33');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (52, 'Vidal', 'Heidenreich', 'wilderman.tiana@example.net', '(162)168-0575x05082', '1997-03-17 17:28:46', '2006-02-18 07:05:29');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (53, 'Hannah', 'Monahan', 'beau46@example.net', '313-071-5116', '2003-09-08 18:07:21', '1994-12-16 05:25:14');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (54, 'Edmund', 'Emmerich', 'wisozk.simone@example.net', '286-940-4739x240', '2006-10-16 15:30:54', '1971-04-28 22:50:32');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (55, 'Brennon', 'Oberbrunner', 'gusikowski.cielo@example.com', '1-752-592-9601x979', '2003-08-11 12:16:43', '2001-10-03 09:58:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (56, 'Junius', 'Boehm', 'vada04@example.net', '285-127-7952', '1990-06-02 01:37:51', '2001-02-12 04:33:54');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (57, 'Dax', 'Anderson', 'vivian66@example.com', '794.113.6542x23039', '1977-04-03 05:43:00', '1997-01-22 21:19:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (58, 'Elias', 'Leuschke', 'cassandra57@example.org', '1-968-049-9064x197', '2002-11-07 01:12:12', '2003-11-18 10:21:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (59, 'Brent', 'Williamson', 'barrows.braulio@example.com', '(787)190-1225', '1997-06-01 18:51:01', '2003-02-07 02:43:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (60, 'Tom', 'Zieme', 'kevon24@example.com', '(292)193-4440x63633', '1985-04-15 19:16:41', '2003-02-13 14:26:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (61, 'Emmett', 'Collins', 'shane50@example.com', '227.409.3781x8384', '1989-04-21 16:47:15', '1999-08-11 06:13:12');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (62, 'Alycia', 'Schultz', 'joshuah73@example.org', '445.030.9554', '1984-07-27 07:08:38', '2000-07-04 08:56:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (63, 'Fay', 'Fahey', 'courtney86@example.net', '133-421-2832x4662', '1988-08-14 13:09:54', '2007-10-11 23:25:53');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (64, 'Dariana', 'Stehr', 'arden.russel@example.net', '(549)693-3782x1469', '1995-05-04 08:22:22', '2021-06-07 05:21:02');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (65, 'Jovany', 'Collins', 'ulices67@example.net', '080.344.7016x5653', '2021-02-12 08:48:41', '1992-08-15 05:59:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (66, 'Natalie', 'Stamm', 'awiza@example.org', '1-881-552-4978x78247', '2005-10-11 13:18:55', '2011-01-14 06:13:48');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (67, 'Zaria', 'Reynolds', 'sadye.langosh@example.net', '1-905-611-2831x6678', '1972-09-05 02:55:19', '1970-12-07 20:38:51');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (68, 'Seth', 'Prosacco', 'vsteuber@example.org', '600-507-3059', '1997-06-02 16:59:26', '2016-07-18 19:16:34');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (69, 'Annamarie', 'Wyman', 'cassin.libbie@example.net', '002-063-0577', '2002-08-18 02:07:20', '2012-01-15 02:34:52');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (70, 'Graham', 'Green', 'mario.green@example.com', '(463)617-6741', '2005-07-18 21:11:37', '2016-05-13 19:11:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (71, 'Markus', 'Ondricka', 'alaina30@example.org', '(140)819-4008x256', '1995-02-27 10:29:47', '1981-03-23 10:25:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (72, 'Rosina', 'Casper', 'alene91@example.com', '639-891-3319x5408', '1993-11-11 02:53:31', '1998-07-27 15:50:10');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (73, 'Wilburn', 'Jenkins', 'darian28@example.com', '+58(0)8623481367', '2009-02-17 04:34:45', '2006-06-16 01:19:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (74, 'Antonette', 'Lowe', 'eino88@example.com', '1-520-626-3979x0014', '2000-06-19 11:20:26', '2008-09-07 17:05:58');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (75, 'Edgardo', 'Stiedemann', 'eboehm@example.net', '997.745.2821', '2005-11-03 09:34:26', '2000-03-10 04:49:19');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (76, 'Ivah', 'Eichmann', 'ugrady@example.com', '856-098-0954x0099', '1991-08-26 04:27:33', '2006-11-05 18:58:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (77, 'Magali', 'Bradtke', 'ralph.dietrich@example.com', '1-033-458-6697x4883', '2008-03-27 11:25:25', '2006-01-06 04:09:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (78, 'Ervin', 'Conn', 'tabitha90@example.org', '05000301417', '1980-09-02 07:14:55', '2006-06-15 10:25:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (79, 'Agnes', 'Labadie', 'annie82@example.org', '(380)698-5779x9878', '1970-05-26 11:28:57', '2002-12-21 21:16:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (80, 'Mara', 'Runolfsson', 'klynch@example.net', '1-836-164-8030x80667', '1991-03-31 09:19:08', '2017-11-26 05:18:11');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (81, 'Kyla', 'Kessler', 'icarter@example.org', '1-568-569-3872', '2007-01-16 19:09:44', '1988-03-29 08:04:37');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (82, 'Veronica', 'Leannon', 'maureen.ritchie@example.net', '+24(3)6604179013', '1974-09-12 10:26:19', '1978-08-18 05:18:59');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (83, 'Norma', 'Cummerata', 'kkassulke@example.com', '544.596.7776', '2001-10-04 01:27:29', '2008-07-21 13:54:43');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (84, 'Natasha', 'Mayert', 'kuhn.presley@example.com', '1-972-338-2245x691', '1970-12-04 19:22:06', '1986-11-22 20:08:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (85, 'Breanne', 'Abshire', 'ikling@example.com', '(311)723-2880', '1984-06-18 08:53:41', '1986-12-17 04:57:03');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (86, 'Jabari', 'Kilback', 'laurel.kihn@example.org', '05571414151', '1991-05-21 05:26:01', '1982-07-13 16:43:04');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (87, 'Jessika', 'Zboncak', 'graham.joaquin@example.com', '1-753-085-3288x56230', '1973-03-06 01:51:01', '1971-03-05 21:05:13');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (88, 'Name', 'Tremblay', 'marley.collier@example.net', '(344)020-8043x004', '1980-02-26 23:30:07', '1977-02-11 08:14:07');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (89, 'Juston', 'Schumm', 'dpowlowski@example.net', '113-641-2278', '1989-12-25 13:16:29', '2000-07-27 20:32:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (90, 'Earlene', 'Lind', 'mbernhard@example.net', '07235473258', '2014-07-01 05:28:20', '1992-06-09 03:12:47');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (91, 'Wilbert', 'Kovacek', 'darrick57@example.net', '(724)392-3408x648', '2010-02-24 10:45:28', '1970-03-16 13:41:44');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (92, 'Oma', 'Koss', 'wlubowitz@example.org', '(722)625-6840', '1981-06-25 20:48:06', '2017-07-22 10:57:16');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (93, 'Pauline', 'Bauch', 'callie25@example.org', '528-695-6573x820', '2017-12-30 10:17:47', '1985-09-24 03:55:42');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (94, 'Christa', 'Wyman', 'wolff.darian@example.com', '(404)097-5098x18418', '1970-06-17 20:14:27', '2000-08-13 21:09:17');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (95, 'Damaris', 'Skiles', 'fkuhlman@example.com', '1-078-109-6518x6905', '1973-02-28 19:40:21', '2002-11-07 19:32:36');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (96, 'Kellen', 'Rath', 'bauch.houston@example.org', '+45(4)9747936250', '2010-05-28 01:20:57', '2017-03-08 11:30:39');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (97, 'Tanya', 'Heidenreich', 'xstanton@example.org', '771.040.5895', '2003-12-16 21:03:05', '1976-11-27 20:23:49');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (98, 'Johnathon', 'Turcotte', 'kkoch@example.org', '(624)085-9453', '1984-02-15 23:06:34', '1981-07-07 11:51:18');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (99, 'Aliza', 'Rempel', 'stehr.gilda@example.org', '895.838.3833x5549', '1989-02-02 08:52:36', '1971-07-27 17:54:20');
INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `created_at`, `updated_at`) VALUES (100, 'Abigale', 'Luettgen', 'alexandrea.wunsch@example.net', '965.945.9955x85498', '2020-03-24 07:01:47', '1980-01-15 11:09:31');


