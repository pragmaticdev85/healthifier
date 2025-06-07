<?php

declare(strict_types=1);

namespace App\Infrastructure\Persistence\User;

use App\Domain\User\User;
use App\Domain\User\UserNotFoundException;
use App\Domain\User\UserRepository;

use Doctrine\DBAL\DriverManager;



class InMemoryUserRepository implements UserRepository
{
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
            'host' => 'localhost',
            'driver' => 'pdo_mysql',
        ];
        $conn = DriverManager::getConnection($connectionParams);
        $sql = "SELECT * FROM User";
        $stmt = $conn->executeQuery($sql); // Simple, but has several drawbacks

        $this->users = [];
        while (($row = $stmt->fetchAssociative()) !== false) {
            array_push($this->users, new User($row['id'], $row['username'], $row['firstName'], $row['lastName']));
        }
       
        /*
        $this->users = $users ?? [
            1 => new User(1, 'bill.gates', 'Bill', 'Gates'),
            2 => new User(2, 'steve.jobs', 'Steve', 'Jobs'),
            3 => new User(3, 'mark.zuckerberg', 'Mark', 'Zuckerberg'),
            4 => new User(4, 'evan.spiegel', 'Evan', 'Spiegel'),
            5 => new User(5, 'jack.dorsey', 'Jack', 'Dorsey'),
        ];
        */
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
