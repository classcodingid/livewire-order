<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Category;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
        // $this->call([
        //     CountrySeeder::class,
        // ]);

        User::factory(10)->create();

        $this->call([
            CountrySeeder::class,
        ]);

        Product::factory(10)->create()->each(function ($product) {
            $product->categories()
                ->saveMany(Category::factory(mt_rand(1, 2))->make());
        });
    }
}

//jalankan 
//php artisan migrate:fresh --seed
