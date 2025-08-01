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
        User::updateOrCreate(
            ['email' => 'vip@example.com'],
            [
                'name' => 'VIP Demo User',
                'password' => Hash::make('password'),
                'vip_tier' => 'platinum',
                'total_spent' => 5000.00,
                'preferences' => ['luxury', 'exclusive']
            ]
        );

        // Create Regular demo user
        User::updateOrCreate(
            ['email' => 'regular@example.com'],
            [
                'name' => 'Regular Demo User',
                'password' => Hash::make('password'),
                'vip_tier' => 'bronze',
                'total_spent' => 100.00,
                'preferences' => ['basic']
            ]
        );
    }
}