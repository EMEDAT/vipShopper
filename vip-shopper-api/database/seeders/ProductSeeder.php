<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    public function run()
    {
        $products = [
            // VIP EXCLUSIVE PRODUCTS (20 items)
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
                'name' => 'Hermès Silk Carré',
                'description' => 'Limited edition silk scarf with hand-rolled edges',
                'price' => 450.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1601924994987-69e26d50dc26?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
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
                'name' => 'Patek Philippe Nautilus',
                'description' => 'Ultra-exclusive luxury sports watch in steel',
                'price' => 35000.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Ferrari 488 GTB',
                'description' => 'Italian supercar with twin-turbo V8 engine',
                'price' => 262000.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Tiffany Diamond Necklace',
                'description' => 'Platinum necklace with exceptional diamonds',
                'price' => 15000.00,
                'category' => 'Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Hermès Birkin 35',
                'description' => 'The most coveted luxury handbag in the world',
                'price' => 22000.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Audemars Piguet Royal Oak',
                'description' => 'Iconic octagonal luxury sports watch',
                'price' => 28000.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Chanel Haute Couture Dress',
                'description' => 'Exclusive runway piece from Paris Fashion Week',
                'price' => 18000.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Lamborghini Huracán',
                'description' => 'Italian V10 supercar with all-wheel drive',
                'price' => 248000.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Van Cleef & Arpels Earrings',
                'description' => 'Exceptional high jewelry with precious stones',
                'price' => 12500.00,
                'category' => 'Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Gucci Limited Edition Bag',
                'description' => 'Exclusive collector piece with gold hardware',
                'price' => 4200.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Richard Mille RM011',
                'description' => 'Ultra-light titanium racing chronograph',
                'price' => 85000.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bulgari Serpenti Watch',
                'description' => 'Iconic snake-inspired luxury timepiece',
                'price' => 16000.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Porsche 911 Turbo S',
                'description' => 'German engineering excellence in sports car form',
                'price' => 207000.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Chopard Happy Diamonds',
                'description' => 'Iconic floating diamonds luxury watch',
                'price' => 22000.00,
                'category' => 'Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Saint Laurent Le Smoking',
                'description' => 'Iconic tuxedo jacket from legendary collection',
                'price' => 3900.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'McLaren 720S',
                'description' => 'British supercar with carbon fiber construction',
                'price' => 299000.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => true
            ],

            // REGULAR PRODUCTS (25 items)
            [
                'name' => 'MacBook Pro M4 Max',
                'description' => 'Latest Apple laptop with AI capabilities and Liquid Retina XDR display',
                'price' => 2499.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Tesla Model S Plaid',
                'description' => 'Electric luxury sedan with tri-motor all-wheel drive',
                'price' => 89990.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800&q=90&fit=crop&crop=center',
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
            ],
            [
                'name' => 'iPhone 15 Pro Max',
                'description' => 'Latest Apple smartphone with titanium build',
                'price' => 1199.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Nike Air Jordan 1 Retro',
                'description' => 'Classic basketball sneaker with premium leather',
                'price' => 170.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Samsung Galaxy S24 Ultra',
                'description' => 'Flagship Android phone with S Pen',
                'price' => 1299.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Canon EOS R5',
                'description' => 'Professional mirrorless camera with 8K video',
                'price' => 3899.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Yeti Rambler Tumbler',
                'description' => 'Insulated stainless steel drinkware',
                'price' => 35.00,
                'category' => 'Lifestyle',
                'image_url' => 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Levi\'s 501 Original Jeans',
                'description' => 'Classic straight-leg denim jeans',
                'price' => 98.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'iPad Pro 12.9"',
                'description' => 'Large tablet with M4 chip and Magic Keyboard support',
                'price' => 1099.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Adidas Ultraboost 22',
                'description' => 'Premium running shoes with Boost technology',
                'price' => 190.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Bose QuietComfort 45',
                'description' => 'Wireless noise-canceling headphones',
                'price' => 329.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Ray-Ban Aviator Classic',
                'description' => 'Iconic pilot sunglasses with gold frame',
                'price' => 154.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Nintendo Switch OLED',
                'description' => 'Portable gaming console with OLED screen',
                'price' => 349.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Dyson V15 Detect',
                'description' => 'Cordless vacuum with laser dust detection',
                'price' => 749.00,
                'category' => 'Home',
                'image_url' => 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'KitchenAid Stand Mixer',
                'description' => 'Professional 5-quart stand mixer',
                'price' => 429.00,
                'category' => 'Home',
                'image_url' => 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Allbirds Tree Runners',
                'description' => 'Sustainable sneakers made from eucalyptus tree',
                'price' => 98.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Apple Watch Series 9',
                'description' => 'Advanced smartwatch with health monitoring',
                'price' => 399.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1551816230-ef5deaed4a26?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Patagonia Down Jacket',
                'description' => 'Lightweight insulated outdoor jacket',
                'price' => 249.00,
                'category' => 'Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1544966503-7cc5ac882d5a?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Hydro Flask Water Bottle',
                'description' => 'Insulated stainless steel water bottle',
                'price' => 44.95,
                'category' => 'Lifestyle',
                'image_url' => 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Tesla Model 3',
                'description' => 'Electric sedan with autopilot capabilities',
                'price' => 38990.00,
                'category' => 'Automotive',
                'image_url' => 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Fitbit Charge 5',
                'description' => 'Advanced fitness and health tracker',
                'price' => 179.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1551816230-ef5deaed4a26?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Instant Pot Duo 7-in-1',
                'description' => 'Multi-functional electric pressure cooker',
                'price' => 99.00,
                'category' => 'Home',
                'image_url' => 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&q=90&fit=crop&crop=center',
                'is_vip_exclusive' => false
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}