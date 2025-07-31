<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    public function run()
    {
        $products = [
            [
                'name' => 'Rolex Submariner',
                'description' => 'Luxury Swiss watch with diving capabilities',
                'price' => 12500.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=300',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Louis Vuitton Handbag',
                'description' => 'Exclusive leather handbag from Paris',
                'price' => 3200.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=300',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'MacBook Pro M4',
                'description' => 'Latest Apple laptop with AI capabilities',
                'price' => 2499.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=300',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Hermès Scarf',
                'description' => 'Limited edition silk scarf',
                'price' => 450.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=300',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Tesla Model S Plaid',
                'description' => 'Electric luxury sedan with autopilot',
                'price' => 89990.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300',
                'is_vip_exclusive' => true
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}