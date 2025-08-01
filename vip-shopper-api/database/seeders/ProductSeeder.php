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
                'description' => 'Luxury Swiss watch with diving capabilities and ceramic bezel',
                'price' => 12500.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Louis Vuitton Capucines',
                'description' => 'Exclusive leather handbag crafted in French ateliers',
                'price' => 3200.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'MacBook Pro M4 Max',
                'description' => 'Latest Apple laptop with AI capabilities and Liquid Retina XDR display',
                'price' => 2499.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Hermès Silk Carré',
                'description' => 'Limited edition silk scarf with hand-rolled edges',
                'price' => 450.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Tesla Model S Plaid',
                'description' => 'Electric luxury sedan with tri-motor all-wheel drive',
                'price' => 89990.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Patek Philippe Nautilus',
                'description' => 'Iconic luxury sports watch with blue dial',
                'price' => 35000.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'iPhone 16 Pro Max',
                'description' => 'Latest flagship smartphone with titanium design',
                'price' => 1199.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Chanel No. 5 Parfum',
                'description' => 'Timeless fragrance in crystal bottle',
                'price' => 185.00,
                'category' => 'Beauty',
                'image_url' => 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Cartier Love Bracelet',
                'description' => 'Iconic 18k gold bracelet with screw motifs',
                'price' => 7250.00,
                'category' => 'Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bottega Veneta Pouch',
                'description' => 'Signature intrecciato woven leather clutch',
                'price' => 1580.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Sony WH-1000XM5',
                'description' => 'Premium noise-canceling wireless headphones',
                'price' => 349.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Tom Ford Oud Wood',
                'description' => 'Luxury unisex fragrance with rare oud blend',
                'price' => 280.00,
                'category' => 'Beauty',
                'image_url' => 'https://images.unsplash.com/photo-1594736797933-d0d9945d2ba5?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}