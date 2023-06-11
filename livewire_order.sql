-- -------------------------------------------------------------
-- TablePlus 3.11.0(352)
--
-- https://tableplus.com/
--
-- Database: livewire_order
-- Generation Time: 2023-06-11 22:09:41.5290
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `position` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `category_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_product_category_id_foreign` (`category_id`),
  KEY `category_product_product_id_foreign` (`product_id`),
  CONSTRAINT `category_product_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_product` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) unsigned NOT NULL,
  `product_id` bigint(20) unsigned NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `order_product_order_id_foreign` (`order_id`),
  KEY `order_product_product_id_foreign` (`product_id`),
  CONSTRAINT `order_product_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `order_date` date NOT NULL,
  `subtotal` int(11) NOT NULL,
  `taxes` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `orders_user_id_foreign` (`user_id`),
  CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `parkings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `vehicle_id` bigint(20) unsigned NOT NULL,
  `zone_id` bigint(20) unsigned NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `stop_time` datetime DEFAULT NULL,
  `total_price` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parkings_user_id_foreign` (`user_id`),
  KEY `parkings_vehicle_id_foreign` (`vehicle_id`),
  KEY `parkings_zone_id_foreign` (`zone_id`),
  CONSTRAINT `parkings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `parkings_vehicle_id_foreign` FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles` (`id`),
  CONSTRAINT `parkings_zone_id_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_id` bigint(20) unsigned NOT NULL,
  `price` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_country_id_foreign` (`country_id`),
  CONSTRAINT `products_country_id_foreign` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `question_options` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correct` tinyint(1) DEFAULT '0',
  `question_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_options_question_id_foreign` (`question_id`),
  CONSTRAINT `question_options_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `question_quiz` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `quiz_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_quiz_question_id_foreign` (`question_id`),
  KEY `question_quiz_quiz_id_foreign` (`quiz_id`),
  CONSTRAINT `question_quiz_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_quiz_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `code_snippet` text COLLATE utf8mb4_unicode_ci,
  `answer_explanation` text COLLATE utf8mb4_unicode_ci,
  `more_info_link` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `quizzes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  `published` tinyint(1) DEFAULT '0',
  `public` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `test_answers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `correct` tinyint(1) DEFAULT '0',
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `test_id` bigint(20) unsigned DEFAULT NULL,
  `question_id` bigint(20) unsigned DEFAULT NULL,
  `option_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `test_answers_user_id_foreign` (`user_id`),
  KEY `test_answers_test_id_foreign` (`test_id`),
  KEY `test_answers_question_id_foreign` (`question_id`),
  KEY `test_answers_option_id_foreign` (`option_id`),
  CONSTRAINT `test_answers_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `question_options` (`id`),
  CONSTRAINT `test_answers_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`),
  CONSTRAINT `test_answers_test_id_foreign` FOREIGN KEY (`test_id`) REFERENCES `tests` (`id`),
  CONSTRAINT `test_answers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `tests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `result` int(11) DEFAULT NULL,
  `ip_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time_spent` int(11) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `quiz_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tests_user_id_foreign` (`user_id`),
  KEY `tests_quiz_id_foreign` (`quiz_id`),
  CONSTRAINT `tests_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`),
  CONSTRAINT `tests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `facebook_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `google_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `github_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `vehicles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `plate_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vehicles_user_id_foreign` (`user_id`),
  CONSTRAINT `vehicles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `zones` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_hour` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `slug`, `is_active`, `position`, `created_at`, `updated_at`) VALUES
('1', 'Lake Sandyview', 'lake-sandyview', '1', '6', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('2', 'Marleneton', 'marleneton', '1', '5', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('3', 'Lake Kathryne', 'lake-kathryne', '1', '7', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('4', 'New Elbert', 'new-elbert', '1', '10', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('5', 'Humbertochester', 'humbertochester', '1', '9', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('6', 'Lake Zanderstad', 'lake-zanderstad', '1', '6', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('7', 'Mireyaville', 'mireyaville', '1', '2', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('8', 'North Reannaside', 'north-reannaside', '1', '3', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('9', 'Velvaton', 'velvaton', '1', '6', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('10', 'Port Fredastad', 'port-fredastad', '1', '4', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('11', 'West Ronview', 'west-ronview', '1', '3', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('12', 'South Angelview', 'south-angelview', '1', '7', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('13', 'New Jeraldbury', 'new-jeraldbury', '1', '7', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('14', 'North Karson', 'north-karson', '1', '6', '2023-06-10 01:18:11', '2023-06-10 01:18:11');

INSERT INTO `category_product` (`id`, `category_id`, `product_id`, `created_at`, `updated_at`) VALUES
('1', '1', '1', NULL, NULL),
('2', '2', '2', NULL, NULL),
('3', '3', '2', NULL, NULL),
('4', '4', '3', NULL, NULL),
('5', '5', '4', NULL, NULL),
('6', '6', '5', NULL, NULL),
('7', '7', '5', NULL, NULL),
('8', '8', '6', NULL, NULL),
('9', '9', '7', NULL, NULL),
('10', '10', '8', NULL, NULL),
('11', '11', '9', NULL, NULL),
('12', '12', '9', NULL, NULL),
('13', '13', '10', NULL, NULL),
('14', '14', '10', NULL, NULL);

INSERT INTO `countries` (`id`, `name`, `short_code`, `created_at`, `updated_at`) VALUES
('1', 'Afghanistan', 'af', NULL, NULL),
('2', 'Albania', 'al', NULL, NULL),
('3', 'Algeria', 'dz', NULL, NULL),
('4', 'American Samoa', 'as', NULL, NULL),
('5', 'Andorra', 'ad', NULL, NULL),
('6', 'Angola', 'ao', NULL, NULL),
('7', 'Anguilla', 'ai', NULL, NULL),
('8', 'Antarctica', 'aq', NULL, NULL),
('9', 'Antigua and Barbuda', 'ag', NULL, NULL),
('10', 'Argentina', 'ar', NULL, NULL),
('11', 'Armenia', 'am', NULL, NULL),
('12', 'Aruba', 'aw', NULL, NULL),
('13', 'Australia', 'au', NULL, NULL),
('14', 'Austria', 'at', NULL, NULL),
('15', 'Azerbaijan', 'az', NULL, NULL),
('16', 'Bahamas', 'bs', NULL, NULL),
('17', 'Bahrain', 'bh', NULL, NULL),
('18', 'Bangladesh', 'bd', NULL, NULL),
('19', 'Barbados', 'bb', NULL, NULL),
('20', 'Belarus', 'by', NULL, NULL),
('21', 'Belgium', 'be', NULL, NULL),
('22', 'Belize', 'bz', NULL, NULL),
('23', 'Benin', 'bj', NULL, NULL),
('24', 'Bermuda', 'bm', NULL, NULL),
('25', 'Bhutan', 'bt', NULL, NULL),
('26', 'Bolivia', 'bo', NULL, NULL),
('27', 'Bosnia and Herzegovina', 'ba', NULL, NULL),
('28', 'Botswana', 'bw', NULL, NULL),
('29', 'Brazil', 'br', NULL, NULL),
('30', 'British Indian Ocean Territory', 'io', NULL, NULL),
('31', 'British Virgin Islands', 'vg', NULL, NULL),
('32', 'Brunei', 'bn', NULL, NULL),
('33', 'Bulgaria', 'bg', NULL, NULL),
('34', 'Burkina Faso', 'bf', NULL, NULL),
('35', 'Burundi', 'bi', NULL, NULL),
('36', 'Cambodia', 'kh', NULL, NULL),
('37', 'Cameroon', 'cm', NULL, NULL),
('38', 'Canada', 'ca', NULL, NULL),
('39', 'Cape Verde', 'cv', NULL, NULL),
('40', 'Cayman Islands', 'ky', NULL, NULL),
('41', 'Central African Republic', 'cf', NULL, NULL),
('42', 'Chad', 'td', NULL, NULL),
('43', 'Chile', 'cl', NULL, NULL),
('44', 'China', 'cn', NULL, NULL),
('45', 'Christmas Island', 'cx', NULL, NULL),
('46', 'Cocos Islands', 'cc', NULL, NULL),
('47', 'Colombia', 'co', NULL, NULL),
('48', 'Comoros', 'km', NULL, NULL),
('49', 'Cook Islands', 'ck', NULL, NULL),
('50', 'Costa Rica', 'cr', NULL, NULL),
('51', 'Croatia', 'hr', NULL, NULL),
('52', 'Cuba', 'cu', NULL, NULL),
('53', 'Curacao', 'cw', NULL, NULL),
('54', 'Cyprus', 'cy', NULL, NULL),
('55', 'Czech Republic', 'cz', NULL, NULL),
('56', 'Democratic Republic of the Congo', 'cd', NULL, NULL),
('57', 'Denmark', 'dk', NULL, NULL),
('58', 'Djibouti', 'dj', NULL, NULL),
('59', 'Dominica', 'dm', NULL, NULL),
('60', 'Dominican Republic', 'do', NULL, NULL),
('61', 'East Timor', 'tl', NULL, NULL),
('62', 'Ecuador', 'ec', NULL, NULL),
('63', 'Egypt', 'eg', NULL, NULL),
('64', 'El Salvador', 'sv', NULL, NULL),
('65', 'Equatorial Guinea', 'gq', NULL, NULL),
('66', 'Eritrea', 'er', NULL, NULL),
('67', 'Estonia', 'ee', NULL, NULL),
('68', 'Ethiopia', 'et', NULL, NULL),
('69', 'Falkland Islands', 'fk', NULL, NULL),
('70', 'Faroe Islands', 'fo', NULL, NULL),
('71', 'Fiji', 'fj', NULL, NULL),
('72', 'Finland', 'fi', NULL, NULL),
('73', 'France', 'fr', NULL, NULL),
('74', 'French Polynesia', 'pf', NULL, NULL),
('75', 'Gabon', 'ga', NULL, NULL),
('76', 'Gambia', 'gm', NULL, NULL),
('77', 'Georgia', 'ge', NULL, NULL),
('78', 'Germany', 'de', NULL, NULL),
('79', 'Ghana', 'gh', NULL, NULL),
('80', 'Gibraltar', 'gi', NULL, NULL),
('81', 'Greece', 'gr', NULL, NULL),
('82', 'Greenland', 'gl', NULL, NULL),
('83', 'Grenada', 'gd', NULL, NULL),
('84', 'Guam', 'gu', NULL, NULL),
('85', 'Guatemala', 'gt', NULL, NULL),
('86', 'Guernsey', 'gg', NULL, NULL),
('87', 'Guinea', 'gn', NULL, NULL),
('88', 'Guinea-Bissau', 'gw', NULL, NULL),
('89', 'Guyana', 'gy', NULL, NULL),
('90', 'Haiti', 'ht', NULL, NULL),
('91', 'Honduras', 'hn', NULL, NULL),
('92', 'Hong Kong', 'hk', NULL, NULL),
('93', 'Hungary', 'hu', NULL, NULL),
('94', 'Iceland', 'is', NULL, NULL),
('95', 'India', 'in', NULL, NULL),
('96', 'Indonesia', 'id', NULL, NULL),
('97', 'Iran', 'ir', NULL, NULL),
('98', 'Iraq', 'iq', NULL, NULL),
('99', 'Ireland', 'ie', NULL, NULL),
('100', 'Isle of Man', 'im', NULL, NULL),
('101', 'Israel', 'il', NULL, NULL),
('102', 'Italy', 'it', NULL, NULL),
('103', 'Ivory Coast', 'ci', NULL, NULL),
('104', 'Jamaica', 'jm', NULL, NULL),
('105', 'Japan', 'jp', NULL, NULL),
('106', 'Jersey', 'je', NULL, NULL),
('107', 'Jordan', 'jo', NULL, NULL),
('108', 'Kazakhstan', 'kz', NULL, NULL),
('109', 'Kenya', 'ke', NULL, NULL),
('110', 'Kiribati', 'ki', NULL, NULL),
('111', 'Kosovo', 'xk', NULL, NULL),
('112', 'Kuwait', 'kw', NULL, NULL),
('113', 'Kyrgyzstan', 'kg', NULL, NULL),
('114', 'Laos', 'la', NULL, NULL),
('115', 'Latvia', 'lv', NULL, NULL),
('116', 'Lebanon', 'lb', NULL, NULL),
('117', 'Lesotho', 'ls', NULL, NULL),
('118', 'Liberia', 'lr', NULL, NULL),
('119', 'Libya', 'ly', NULL, NULL),
('120', 'Liechtenstein', 'li', NULL, NULL),
('121', 'Lithuania', 'lt', NULL, NULL),
('122', 'Luxembourg', 'lu', NULL, NULL),
('123', 'Macau', 'mo', NULL, NULL),
('124', 'North Macedonia', 'mk', NULL, NULL),
('125', 'Madagascar', 'mg', NULL, NULL),
('126', 'Malawi', 'mw', NULL, NULL),
('127', 'Malaysia', 'my', NULL, NULL),
('128', 'Maldives', 'mv', NULL, NULL),
('129', 'Mali', 'ml', NULL, NULL),
('130', 'Malta', 'mt', NULL, NULL),
('131', 'Marshall Islands', 'mh', NULL, NULL),
('132', 'Mauritania', 'mr', NULL, NULL),
('133', 'Mauritius', 'mu', NULL, NULL),
('134', 'Mayotte', 'yt', NULL, NULL),
('135', 'Mexico', 'mx', NULL, NULL),
('136', 'Micronesia', 'fm', NULL, NULL),
('137', 'Moldova', 'md', NULL, NULL),
('138', 'Monaco', 'mc', NULL, NULL),
('139', 'Mongolia', 'mn', NULL, NULL),
('140', 'Montenegro', 'me', NULL, NULL),
('141', 'Montserrat', 'ms', NULL, NULL),
('142', 'Morocco', 'ma', NULL, NULL),
('143', 'Mozambique', 'mz', NULL, NULL),
('144', 'Myanmar', 'mm', NULL, NULL),
('145', 'Namibia', 'na', NULL, NULL),
('146', 'Nauru', 'nr', NULL, NULL),
('147', 'Nepal', 'np', NULL, NULL),
('148', 'Netherlands', 'nl', NULL, NULL),
('149', 'Netherlands Antilles', 'an', NULL, NULL),
('150', 'New Caledonia', 'nc', NULL, NULL),
('151', 'New Zealand', 'nz', NULL, NULL),
('152', 'Nicaragua', 'ni', NULL, NULL),
('153', 'Niger', 'ne', NULL, NULL),
('154', 'Nigeria', 'ng', NULL, NULL),
('155', 'Niue', 'nu', NULL, NULL),
('156', 'North Korea', 'kp', NULL, NULL),
('157', 'Northern Mariana Islands', 'mp', NULL, NULL),
('158', 'Norway', 'no', NULL, NULL),
('159', 'Oman', 'om', NULL, NULL),
('160', 'Pakistan', 'pk', NULL, NULL),
('161', 'Palau', 'pw', NULL, NULL),
('162', 'Palestine', 'ps', NULL, NULL),
('163', 'Panama', 'pa', NULL, NULL),
('164', 'Papua New Guinea', 'pg', NULL, NULL),
('165', 'Paraguay', 'py', NULL, NULL),
('166', 'Peru', 'pe', NULL, NULL),
('167', 'Philippines', 'ph', NULL, NULL),
('168', 'Pitcairn', 'pn', NULL, NULL),
('169', 'Poland', 'pl', NULL, NULL),
('170', 'Portugal', 'pt', NULL, NULL),
('171', 'Puerto Rico', 'pr', NULL, NULL),
('172', 'Qatar', 'qa', NULL, NULL),
('173', 'Republic of the Congo', 'cg', NULL, NULL),
('174', 'Reunion', 're', NULL, NULL),
('175', 'Romania', 'ro', NULL, NULL),
('176', 'Russia', 'ru', NULL, NULL),
('177', 'Rwanda', 'rw', NULL, NULL),
('178', 'Saint Barthelemy', 'bl', NULL, NULL),
('179', 'Saint Helena', 'sh', NULL, NULL),
('180', 'Saint Kitts and Nevis', 'kn', NULL, NULL),
('181', 'Saint Lucia', 'lc', NULL, NULL),
('182', 'Saint Martin', 'mf', NULL, NULL),
('183', 'Saint Pierre and Miquelon', 'pm', NULL, NULL),
('184', 'Saint Vincent and the Grenadines', 'vc', NULL, NULL),
('185', 'Samoa', 'ws', NULL, NULL),
('186', 'San Marino', 'sm', NULL, NULL),
('187', 'Sao Tome and Principe', 'st', NULL, NULL),
('188', 'Saudi Arabia', 'sa', NULL, NULL),
('189', 'Senegal', 'sn', NULL, NULL),
('190', 'Serbia', 'rs', NULL, NULL),
('191', 'Seychelles', 'sc', NULL, NULL),
('192', 'Sierra Leone', 'sl', NULL, NULL),
('193', 'Singapore', 'sg', NULL, NULL),
('194', 'Sint Maarten', 'sx', NULL, NULL),
('195', 'Slovakia', 'sk', NULL, NULL),
('196', 'Slovenia', 'si', NULL, NULL),
('197', 'Solomon Islands', 'sb', NULL, NULL),
('198', 'Somalia', 'so', NULL, NULL),
('199', 'South Africa', 'za', NULL, NULL),
('200', 'South Korea', 'kr', NULL, NULL),
('201', 'South Sudan', 'ss', NULL, NULL),
('202', 'Spain', 'es', NULL, NULL),
('203', 'Sri Lanka', 'lk', NULL, NULL),
('204', 'Sudan', 'sd', NULL, NULL),
('205', 'Suriname', 'sr', NULL, NULL),
('206', 'Svalbard and Jan Mayen', 'sj', NULL, NULL),
('207', 'Swaziland', 'sz', NULL, NULL),
('208', 'Sweden', 'se', NULL, NULL),
('209', 'Switzerland', 'ch', NULL, NULL),
('210', 'Syria', 'sy', NULL, NULL),
('211', 'Taiwan', 'tw', NULL, NULL),
('212', 'Tajikistan', 'tj', NULL, NULL),
('213', 'Tanzania', 'tz', NULL, NULL),
('214', 'Thailand', 'th', NULL, NULL),
('215', 'Togo', 'tg', NULL, NULL),
('216', 'Tokelau', 'tk', NULL, NULL),
('217', 'Tonga', 'to', NULL, NULL),
('218', 'Trinidad and Tobago', 'tt', NULL, NULL),
('219', 'Tunisia', 'tn', NULL, NULL),
('220', 'Turkey', 'tr', NULL, NULL),
('221', 'Turkmenistan', 'tm', NULL, NULL),
('222', 'Turks and Caicos Islands', 'tc', NULL, NULL),
('223', 'Tuvalu', 'tv', NULL, NULL),
('224', 'U.S. Virgin Islands', 'vi', NULL, NULL),
('225', 'Uganda', 'ug', NULL, NULL),
('226', 'Ukraine', 'ua', NULL, NULL),
('227', 'United Arab Emirates', 'ae', NULL, NULL),
('228', 'United Kingdom', 'gb', NULL, NULL),
('229', 'United States', 'us', NULL, NULL),
('230', 'Uruguay', 'uy', NULL, NULL),
('231', 'Uzbekistan', 'uz', NULL, NULL),
('232', 'Vanuatu', 'vu', NULL, NULL),
('233', 'Vatican', 'va', NULL, NULL),
('234', 'Venezuela', 've', NULL, NULL),
('235', 'Vietnam', 'vn', NULL, NULL),
('236', 'Wallis and Futuna', 'wf', NULL, NULL),
('237', 'Western Sahara', 'eh', NULL, NULL),
('238', 'Yemen', 'ye', NULL, NULL),
('239', 'Zambia', 'zm', NULL, NULL),
('240', 'Zimbabwe', 'zw', NULL, NULL);

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
('1', '2014_10_12_000000_create_users_table', '1'),
('2', '2014_10_12_100000_create_password_reset_tokens_table', '1'),
('3', '2019_08_19_000000_create_failed_jobs_table', '1'),
('4', '2019_12_14_000001_create_personal_access_tokens_table', '1'),
('5', '2023_06_08_114337_create_categories_table', '1'),
('6', '2023_06_09_012703_create_countries_table', '1'),
('7', '2023_06_09_013157_create_products_table', '1'),
('8', '2023_06_09_013319_create_category_product_table', '1'),
('9', '2023_06_09_035234_create_orders_table', '1'),
('10', '2023_06_09_035432_create_order_product_table', '1'),
('11', '2023_06_09_093055_add_socialite_fields_to_users_table', '1'),
('12', '2023_06_09_100854_add_is_admin_to_users_table', '1'),
('13', '2023_06_09_103111_create_questions_table', '1'),
('14', '2023_06_09_104705_create_question_options_table', '1'),
('15', '2023_06_09_111353_create_quizzes_table', '1'),
('16', '2023_06_09_113137_create_question_quiz_table', '1'),
('17', '2023_06_10_002213_create_tests_table', '1'),
('18', '2023_06_10_002426_create_test_answers_table', '1'),
('19', '2023_06_10_061649_create_vehicles_table', '1'),
('20', '2023_06_10_061939_create_zones_table', '1'),
('21', '2023_06_10_062121_create_parkings_table', '1');

INSERT INTO `order_product` (`id`, `order_id`, `product_id`, `price`, `quantity`, `created_at`, `updated_at`) VALUES
('1', '1', '3', '331', '1', NULL, NULL),
('2', '2', '8', '110', '1', NULL, NULL),
('3', '2', '7', '473', '2', NULL, NULL);

INSERT INTO `orders` (`id`, `user_id`, `order_date`, `subtotal`, `taxes`, `total`, `created_at`, `updated_at`) VALUES
('1', '2', '2023-06-10', '331', '70', '401', '2023-06-10 01:53:54', '2023-06-10 01:53:54'),
('2', '3', '2023-06-11', '1056', '222', '1278', '2023-06-10 01:56:24', '2023-06-10 01:56:24');

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
('1', 'App\\Models\\User', '11', 'Thunder Client (https://www.thunderclient.com)', 'e1255fb60e3adbcfbaaf70f1199c47aca059c0c66a8b54f1a6f5844ae77f4326', '[\"*\"]', NULL, NULL, '2023-06-10 06:35:39', '2023-06-10 06:35:39'),
('2', 'App\\Models\\User', '11', 'Thunder Client (https://www.thunderclient.com)', '43270c0219f566ffcfa5a0add234364ff65be53bd333a7a0dfe2984d8ca9d17e', '[\"*\"]', NULL, '2023-06-10 08:57:30', '2023-06-10 06:57:30', '2023-06-10 06:57:30'),
('3', 'App\\Models\\User', '11', 'Thunder Client (https://www.thunderclient.com)', 'd68eacb2b1d3e71bce19ae38f0227964585453a71eccc023257a62ae467b2a20', '[\"*\"]', NULL, '2023-06-10 09:06:27', '2023-06-10 07:06:27', '2023-06-10 07:06:27'),
('4', 'App\\Models\\User', '11', 'Thunder Client (https://www.thunderclient.com)', 'caa7f12f4d31d3cad30d7dade346d7d8655415455bc31abe592c351ffe794894', '[\"*\"]', NULL, '2023-06-11 02:37:09', '2023-06-11 00:37:09', '2023-06-11 00:37:09'),
('5', 'App\\Models\\User', '1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '9a45b80c7e9fbe8bad30a4b8f708ebf932bd610c466a39672c6cf93c41694466', '[\"*\"]', NULL, '2023-06-11 03:40:25', '2023-06-11 01:40:25', '2023-06-11 01:40:25'),
('6', 'App\\Models\\User', '1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36', '6338238a1849c1f502888522175f57bb578eaed45b6e2d6111355056d57aef96', '[\"*\"]', NULL, '2023-06-11 03:41:38', '2023-06-11 01:41:38', '2023-06-11 01:41:38');

INSERT INTO `products` (`id`, `name`, `description`, `country_id`, `price`, `created_at`, `updated_at`) VALUES
('1', 'Operative foreground toolset', 'He moved on as he said in a very small cake, on which the cook tulip-roots instead of the song. \'What trial is it?\' \'Why,\' said the King said, for about the games now.\' CHAPTER X. The Lobster.', '106', '370', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('2', 'Assimilated cohesive function', 'Mouse to tell him. \'A nice muddle their slates\'ll be in Bill\'s place for a dunce? Go on!\' \'I\'m a poor man, your Majesty,\' he began. \'You\'re a very melancholy voice. \'Repeat, \"YOU ARE OLD, FATHER.', '201', '261', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('3', 'Ameliorated tangible info-mediaries', 'What happened to you? Tell us all about as curious as it settled down in a minute, while Alice thought she might as well to introduce it.\' \'I don\'t think they play at all anxious to have changed.', '15', '331', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('4', 'Multi-tiered exuding protocol', 'Alice, and, after waiting till she got up, and began to repeat it, when a cry of \'The trial\'s beginning!\' was heard in the air. This time there could be beheaded, and that in about half no time!.', '71', '348', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('5', 'Proactive client-server forecast', 'Bill\'s place for a minute or two, looking for eggs, as it was growing, and growing, and growing, and she sat on, with closed eyes, and feebly stretching out one paw, trying to box her own children.', '160', '248', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('6', 'Reverse-engineered content-based workforce', 'I suppose I ought to eat or drink under the hedge. In another minute the whole head appeared, and then the Rabbit\'s little white kid gloves in one hand and a large ring, with the Mouse only growled.', '147', '100', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('7', 'Decentralized coherent benchmark', 'THAT in a large rabbit-hole under the hedge. In another minute the whole party swam to the Duchess: \'flamingoes and mustard both bite. And the moral of that is--\"Birds of a feather flock together.\"\'.', '122', '473', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('8', 'Cross-platform real-time functionalities', 'They all made of solid glass; there was enough of it in a low voice, \'Why the fact is, you know. But do cats eat bats, I wonder?\' Alice guessed in a moment: she looked down into a cucumber-frame, or.', '129', '110', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('9', 'Streamlined transitional knowledgeuser', 'I was going to begin with,\' the Mock Turtle to the Duchess: \'flamingoes and mustard both bite. And the Gryphon said, in a low, hurried tone. He looked at her rather inquisitively, and seemed to be.', '30', '158', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('10', 'Reverse-engineered global conglomeration', 'Mock Turtle Soup is made from,\' said the Mock Turtle. \'Seals, turtles, salmon, and so on; then, when you\'ve cleared all the jurymen on to himself in an offended tone, \'so I can\'t understand it.', '237', '413', '2023-06-10 01:18:11', '2023-06-10 01:18:11');

INSERT INTO `question_options` (`id`, `option`, `correct`, `question_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('4', 'erdogan', '0', '1', '2023-06-10 01:45:35', '2023-06-10 01:45:35', NULL),
('5', 'jokowi', '1', '1', '2023-06-10 01:45:35', '2023-06-10 01:45:35', NULL),
('6', 'ganjar', '0', '1', '2023-06-10 01:45:35', '2023-06-10 01:45:35', NULL),
('7', '8.0', '0', '2', '2023-06-10 01:48:44', '2023-06-10 01:48:44', NULL),
('8', '8.1', '0', '2', '2023-06-10 01:48:44', '2023-06-10 01:48:44', NULL),
('9', '8.2', '1', '2', '2023-06-10 01:48:44', '2023-06-10 01:48:44', NULL),
('10', 'dari sisi server', '0', '3', '2023-06-10 04:27:09', '2023-06-10 04:27:09', NULL),
('11', 'pengolahan request', '0', '3', '2023-06-10 04:27:09', '2023-06-10 04:27:09', NULL),
('12', 'http access', '1', '3', '2023-06-10 04:27:09', '2023-06-10 04:27:09', NULL),
('13', 'java', '0', '4', '2023-06-10 04:31:51', '2023-06-10 04:31:51', NULL),
('14', 'c++', '0', '4', '2023-06-10 04:31:51', '2023-06-10 04:31:51', NULL),
('15', 'visual studio code', '1', '4', '2023-06-10 04:31:51', '2023-06-10 04:31:51', NULL),
('16', 'php', '0', '4', '2023-06-10 04:31:51', '2023-06-10 04:31:51', NULL);

INSERT INTO `question_quiz` (`id`, `question_id`, `quiz_id`, `created_at`, `updated_at`) VALUES
('1', '1', '1', NULL, NULL),
('2', '2', '2', NULL, NULL);

INSERT INTO `questions` (`id`, `question_text`, `code_snippet`, `answer_explanation`, `more_info_link`, `created_at`, `updated_at`, `deleted_at`) VALUES
('1', 'siapa president republik indonesia saat ini?', 'sebutkan nama president ri sekarang', 'jokowi adalah president republik 2 periode', 'https://jokowi.com', '2023-06-10 01:45:26', '2023-06-10 01:45:26', NULL),
('2', 'berapa versi terakhir php saat ini?', 'versi php', 'jadi penjelasannya adalah versi php saat ini adalah 8.2', 'https://php.com', '2023-06-10 01:48:43', '2023-06-10 01:48:43', NULL),
('3', 'apa perbedaan apache dan nginx', 'perbedaan nginx', 'jadi penjelasannya adalah http access', 'https://nginx.com', '2023-06-10 04:27:09', '2023-06-10 04:27:09', NULL),
('4', 'berikut ini yang bukan bahasa pemrograman adalah', 'yang bukan bahasa pemrograman', 'visual studio code bukan merubahan bahasa pemrograman, ia adalah IDE ', 'https://code.visualstudio.com/', '2023-06-10 04:31:51', '2023-06-10 04:31:51', NULL);

INSERT INTO `quizzes` (`id`, `title`, `slug`, `description`, `published`, `public`, `created_at`, `updated_at`, `deleted_at`) VALUES
('1', 'quiz kenegaraan', 'nama-president-ri', 'ini adalah kuis nama president', '1', '1', '2023-06-10 01:47:19', '2023-06-10 01:47:19', NULL),
('2', 'quis pemrograman', 'quis-pemrograman', 'ini adalah kuis pemrograman php', '1', '1', '2023-06-10 01:49:18', '2023-06-10 04:46:26', NULL);

INSERT INTO `test_answers` (`id`, `correct`, `user_id`, `test_id`, `question_id`, `option_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('10', '1', '1', '17', '4', '15', '2023-06-10 04:42:15', '2023-06-10 04:42:15', NULL),
('11', '0', '1', '17', '1', '4', '2023-06-10 04:42:15', '2023-06-10 04:42:15', NULL),
('12', '1', '1', '17', '2', '9', '2023-06-10 04:42:15', '2023-06-10 04:42:15', NULL),
('13', '0', '1', '17', '3', '10', '2023-06-10 04:42:15', '2023-06-10 04:42:15', NULL),
('14', '0', '4', '18', '1', '6', '2023-06-10 04:48:23', '2023-06-10 04:48:23', NULL),
('15', '1', '7', '19', '2', '9', '2023-06-10 04:49:34', '2023-06-10 04:49:34', NULL),
('16', '1', NULL, '20', '1', '5', '2023-06-10 04:51:09', '2023-06-10 04:51:09', NULL),
('17', '0', '4', '21', '2', '8', '2023-06-10 05:45:25', '2023-06-10 05:45:25', NULL),
('18', '0', '4', '22', '2', '7', '2023-06-10 05:45:49', '2023-06-10 05:45:49', NULL);

INSERT INTO `tests` (`id`, `result`, `ip_address`, `time_spent`, `user_id`, `quiz_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
('17', '2', '127.0.0.1', '41', '1', '1', '2023-06-10 04:42:15', '2023-06-10 04:42:15', NULL),
('18', '0', '127.0.0.1', '8', '4', '1', '2023-06-10 04:48:23', '2023-06-10 04:48:23', NULL),
('19', '1', '127.0.0.1', '5', '7', '2', '2023-06-10 04:49:34', '2023-06-10 04:49:34', NULL),
('20', '1', '127.0.0.1', '3', NULL, '1', '2023-06-10 04:51:09', '2023-06-10 04:51:09', NULL),
('21', '0', '127.0.0.1', '4', '4', '2', '2023-06-10 05:45:25', '2023-06-10 05:45:25', NULL),
('22', '0', '127.0.0.1', '2', '4', '2', '2023-06-10 05:45:49', '2023-06-10 05:45:49', NULL);

INSERT INTO `users` (`id`, `username`, `name`, `email`, `email_verified_at`, `password`, `is_admin`, `facebook_id`, `google_id`, `github_id`, `remember_token`, `created_at`, `updated_at`) VALUES
('1', '89086026', 'Nyasia Frami', 'laurence.glover@example.com', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '1', NULL, NULL, NULL, 'EBxYQEdQlYSi2WHsMFSG3Pg5veuDMF5wq9EAe1hImBQk2TrGicLFhxkHm1gy', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('2', '51576791', 'Odell Bradtke', 'price.hazle@example.com', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, '4b4l0uh4Bnhhd46C0puGlf0jR7xOPEhL6RR3WvS2eV6YMQhzer9pKiC2MMIu', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('3', '76519051', 'Yvette Pagac', 'donna79@example.net', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, 'YhHyNQhr6H', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('4', '16711723', 'Zack Shields', 'jakubowski.letitia@example.org', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, '4atjjJoy1c2sRlfG9pleM3xr5M2tXMj5SsVNPf8Wu3lqPTM1rHX7hab3QJ6J', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('5', '74810266', 'Hunter Roberts IV', 'lmckenzie@example.org', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, 'dNsisJd5pwPzdwfQIxBYIyFHxAB3sdBzATueIDGqwwwfepSfahvumOJUciCu', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('6', '96410416', 'Ms. Oceane Parker', 'caesar.mueller@example.org', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, 'ByOlVmMBWM', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('7', '70107328', 'Carmel Brueni', 'stan45@example.com', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, 'BFJ6hNP2rqHB6plnPnpTUTFat6brDkjddEzUnYypWipx3PlvbOHzvgXU7fAC', '2023-06-10 01:18:11', '2023-06-10 04:50:35'),
('8', '08543312', 'Dr. Frances Ratke', 'tmuller@example.org', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, 'nLUlAz2epY', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('9', '10738100', 'Vivian O\'Keefe', 'aankunding@example.org', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, 'lE0FXTu7W0', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('10', '94968471', 'Jake Quigley', 'green.tod@example.com', '2023-06-10 01:18:11', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '1', NULL, NULL, NULL, 'yAZlyffXfb9Rfe9PHfiYkSkW4Dk3coIzbfZinvOC1PPdmWsYibhEczB547FO', '2023-06-10 01:18:11', '2023-06-10 01:18:11'),
('11', '72112442', 'mujabstore', 'mujab@gmail.com', NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', '0', NULL, NULL, NULL, NULL, '2023-06-10 06:35:38', '2023-06-10 06:35:38');

INSERT INTO `zones` (`id`, `name`, `price_per_hour`, `created_at`, `updated_at`) VALUES
('1', 'Green Zone', '100', '2023-06-10 06:22:46', '2023-06-10 06:22:46'),
('2', 'Yellow Zone', '200', '2023-06-10 06:22:46', '2023-06-10 06:22:46'),
('3', 'Red Zone', '300', '2023-06-10 06:22:46', '2023-06-10 06:22:46');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;