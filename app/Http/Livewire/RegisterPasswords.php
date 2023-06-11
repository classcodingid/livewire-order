<?php

namespace App\Http\Livewire;

use ZxcvbnPhp\Zxcvbn;
use Livewire\Component;

class RegisterPasswords extends Component
{
    public string $password = '';

    public string $passwordConfirmation = '';

    public int $strengthScore = 0;

    public array $strengthLevels = [
        1 => 'Weak',
        2 => 'Fair',
        3 => 'Good',
        4 => 'Strong',
    ];

    //update password
    public function updatedPassword($value)
    {
        $this->strengthScore = (new Zxcvbn())->passwordStrength($value)['score'];
    }

    //generate password
    public function generatePassword(): void
    {
        $lowercase = range('a', 'z');
        $uppercase = range('A', 'Z');
        $digits = range(0, 9);
        $special = ['!', '@', '#', '$', '%', '^', '*'];
        $chars = array_merge($lowercase, $uppercase, $digits, $special);
        $length = 12;
        do {
            $password = array();

            for ($i = 0; $i <= $length; $i++) {
                $int = rand(0, count($chars) - 1);
                $password[] = $chars[$int];
            }
        } while (empty(array_intersect($special, $password)));

        $this->setPasswords(implode('', $password));
    }

    //set passwordnya
    private function setPasswords($value): void
    {
        $this->password = $value;
        $this->passwordConfirmation = $value;
        $this->updatedPassword($value);
    }

    //render livewire
    public function render()
    {
        return view('livewire.register-passwords');
    }
}
