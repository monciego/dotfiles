<?php

declare(strict_types=1);

namespace App;

use DateTime;
use Exception;

class User {
    private string $name;
    private int $age;
    private array $hobbies;

    public function __construct(string $name, int $age, array $hobbies = []) {
        $this->name = $name;
        $this->age = $age;
        $this->hobbies = $hobbies;
    }

    public function greet(): string {
        return "Hello, my name is {$this->name} and I am {$this->age} years old.";
    }

    public function addHobby(string $hobby): void {
        if (!in_array($hobby, $this->hobbies)) {
            $this->hobbies[] = $hobby;
        }
    }

    public function getHobbies(): array {
        return $this->hobbies;
    }
}

function showUserInfo(User $user): void {
    echo $user->greet() . PHP_EOL;
    echo "Hobbies: " . implode(', ', $user->getHobbies()) . PHP_EOL;
}

try {
    $user = new User("Monciego", 22, ["coding", "gaming"]);
    $user->addHobby("reading");
    showUserInfo($user);
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}



