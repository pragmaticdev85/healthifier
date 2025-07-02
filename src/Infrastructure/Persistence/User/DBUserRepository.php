<?php

declare(strict_types=1);

namespace App\Infrastructure\Persistence\User;

use App\Domain\User\User;
use App\Domain\User\UserNotFoundException;
use App\Domain\User\UserRepository;

use Doctrine\DBAL\DriverManager;

class DBUserRepository implements UserRepository {

    /**
     * @var User[]
     */
    private array $users;

    /**
     * @param User[]|null $users
     */
    public function __construct(?array $users = null)
    {
        //..
        $connectionParams = [
            'dbname' => 'first_db',
            'user' => 'root',
            'password' => 'my-secret-pw',
            'host' => '127.0.0.1',
            'driver' => 'pdo_mysql',
            'pooled' => 'true'
        ];
        $conn = DriverManager::getConnection($connectionParams);
        $sql = "SELECT * FROM User";
        $stmt = $conn->executeQuery($sql); // Simple, but has several drawbacks

        $this->users = [];
        while (($row = $stmt->fetchAssociative()) !== false) {
            array_push($this->users, new User($row['id'], $row['email_address'], $row['fname'], $row['lname']));
        }
    }

    /**
     * {@inheritdoc}
     */
    public function findAll(): array
    {
        return array_values($this->users);
    }

    /**
     * {@inheritdoc}
     */
    public function findUserOfId(int $id): User
    {
        if (!isset($this->users[$id])) {
            throw new UserNotFoundException();
        }

        return $this->users[$id];
    }
}
