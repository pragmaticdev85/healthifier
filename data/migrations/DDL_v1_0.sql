SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `Role_Action_XRef`;
DROP TABLE IF EXISTS `User_Role_XRef`;
DROP TABLE IF EXISTS `Package_Test_Region_XRef`;
DROP TABLE IF EXISTS `Test_Region_XRef`;
DROP TABLE IF EXISTS `Action`;
DROP TABLE IF EXISTS `Consultation`;
DROP TABLE IF EXISTS `Role`;
DROP TABLE IF EXISTS `Package`;
DROP TABLE IF EXISTS `Region`;
DROP TABLE IF EXISTS `Test`;
DROP TABLE IF EXISTS `User`;

CREATE TABLE `User` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`fname` varchar(64) NOT NULL,
`lname` varchar(64) NOT NULL,
`user_type` ENUM ('PHYSIOTHERAPIST', 'NURSE', 'QUALIFIED_DOCTOR', 'REG_MED_PRACTITIONER', 'PATIENT', 'PORTAL_USER', 'ADMIN', 'LAB_TECHNICIAN') NOT NULL,
`email_address` varchar(128) NOT NULL,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer
);
INSERT INTO `User` (fname, lname, user_type, email_address) VALUES
('Admin', 'Admin', 'ADMIN', 'admin@domain.com');

CREATE TABLE `Test` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`name` varchar(64) NOT NULL,
`description` varchar(255) NOT NULL,
`type` ENUM ('BLOOD', 'URINE', 'OTHER'),
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Region` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`name` varchar(64) NOT NULL,
`city` ENUM ('BENGALURU', 'MUMBAI', 'DELHI', 'HYDERABAD', 'NOIDA', 'GURUGRAM'),
`country` ENUM ('INDIA'),
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Test_Region_XRef` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`health_test_id` integer,
`region_id` integer,
`price_currency` ENUM ('INR', 'USD', 'AED', 'GBP'),
`price_value` float,
`prescription_required` ENUM ('YES', 'NO'),
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Package` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`name` varchar(64) NOT NULL,
`description` varchar(255) NOT NULL,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Package_Test_Region_XRef` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`package_id` integer,
`test_region_xref_id` integer,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Role` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`name` varchar(64) NOT NULL,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `User_Role_XRef` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`user_id` integer,
`role_id` integer,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Consultation` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`user_id` integer,
`scheduled_time` timestamp,
`status` ENUM ('REGISTERED', 'IN_PROGRESS', 'COMPLETED', 'RESCHEDULED', 'CANCELLED'),
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Action` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`name` varchar(128) NOT NULL,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

CREATE TABLE `Role_Action_XRef` (
`id` integer AUTO_INCREMENT PRIMARY KEY,
`action_id` integer NOT NULL,
`role_id` integer NOT NULL,
`created_at` DATETIME NOT NULL DEFAULT NOW(),
`created_by` integer NOT NULL,
`updated_at` DATETIME DEFAULT NOW() ON UPDATE NOW(),
`updated_by` integer NOT NULL
);

ALTER TABLE `Test_Region_XRef` ADD FOREIGN KEY (`health_test_id`) REFERENCES `Test` (`id`);
ALTER TABLE `Test_Region_XRef` ADD FOREIGN KEY (`region_id`) REFERENCES `Region` (`id`);
ALTER TABLE `Package_Test_Region_XRef` ADD FOREIGN KEY (`test_region_xref_id`) REFERENCES `Test_Region_XRef` (`id`);
ALTER TABLE `Package_Test_Region_XRef` ADD FOREIGN KEY (`package_id`) REFERENCES `Package` (`id`);
ALTER TABLE `Test` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Test` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Package` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Package` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Region` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Region` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Test_Region_XRef` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Test_Region_XRef` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Package_Test_Region_XRef` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Package_Test_Region_XRef` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Role` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Role` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `User_Role_XRef` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `User_Role_XRef` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `User_Role_XRef` ADD FOREIGN KEY (`role_id`) REFERENCES `Role` (`id`);
ALTER TABLE `User_Role_XRef` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);
ALTER TABLE `Consultation` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`id`);
ALTER TABLE `Consultation` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Consultation` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `User` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `User` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Action` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Action` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Role_Action_XRef` ADD FOREIGN KEY (`created_by`) REFERENCES `User` (`id`);
ALTER TABLE `Role_Action_XRef` ADD FOREIGN KEY (`updated_by`) REFERENCES `User` (`id`);
ALTER TABLE `Role_Action_XRef` ADD FOREIGN KEY (`action_id`) REFERENCES `Action` (`id`);
ALTER TABLE `Role_Action_XRef` ADD FOREIGN KEY (`role_id`) REFERENCES `Role` (`id`);

SET FOREIGN_KEY_CHECKS = 1;