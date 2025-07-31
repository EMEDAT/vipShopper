<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        // Create VIP test user
        User::factory()->create([
            'name' => 'VIP Customer',
            'email' => 'vip@example.com',
            'vip_tier' => 'platinum',
            'total_spent' => 25000.00,
            'preferences' => ['luxury_watches', 'designer_fashion']
        ]);

        // Create regular user
        User::factory()->create([
            'name' => 'Regular Customer', 
            'email' => 'customer@example.com',
            'vip_tier' => 'bronze',
            'total_spent' => 500.00
        ]);

        // Seed VIP products
        $this->call(ProductSeeder::class);
    }
}