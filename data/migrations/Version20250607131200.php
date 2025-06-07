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
        /*
            $users = [
                ['name' => 'mike', 'id' => 1],
                ['name' => 'jwage', 'id' => 2],
                ['name' => 'ocramius', 'id' => 3],
            ];

            foreach ($users as $user) {
                $this->addSql('UPDATE user SET happy = true WHERE name = :name AND id = :id', $user);
            }

        */
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs

    }
}
