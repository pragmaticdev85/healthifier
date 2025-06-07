<?php

declare(strict_types=1);

namespace initial_setup;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250607131200 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql("CREATE TABLE first_db.`User` (
                id BIGINT auto_increment NOT NULL,
                username varchar(100) NOT NULL,
                firstName varchar(100) NOT NULL,
                lastName varchar(100) NOT NULL,
                CONSTRAINT User_PK PRIMARY KEY (id),
                CONSTRAINT User_UNIQUE UNIQUE KEY (username)
            )
            ENGINE=InnoDB
            DEFAULT CHARSET=utf8mb4
            COLLATE=utf8mb4_0900_ai_ci;"
        );
        $this->addSql("INSERT INTO first_db.`User` (username,firstName,lastName) VALUES 
            ('first.user','First','User'),
	        ('second.user','Second','User'),
	        ('third.user','Third','User');"
        );
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs

    }
}
