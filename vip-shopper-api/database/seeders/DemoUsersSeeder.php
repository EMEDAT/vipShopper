<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class DemoUsersSeeder extends Seeder
{
    public function run(): void
    {
        // Create VIP demo user
        User::create([
            'name' => 'VIP Demo User',
            'email' => 'vip@example.com',
            'password' => Hash::make('password'),
            'vip_tier' => 'platinum',
            'total_spent' => 5000.00,
            'preferences' => ['luxury', 'exclusive']
        ]);

        // Create Regular demo user
        User::create([
            'name' => 'Regular Demo User',
            'email' => 'regular@example.com',
            'password' => Hash::make('password'),
            'vip_tier' => 'bronze',
            'total_spent' => 100.00,
            'preferences' => ['basic']
        ]);
    }
}