<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    public function run()
    {
        // Clear existing products to avoid duplicates
        Product::truncate();
        
        $products = [
            // VIP EXCLUSIVE PRODUCTS - UNIQUE IMAGES FOR EACH
            [
                'name' => 'Rolex Submariner Date',
                'description' => 'Swiss luxury diving watch, 904L steel, ceramic bezel, COSC certified',
                'price' => 13450.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Hermès Birkin 35cm',
                'description' => 'Handcrafted Togo leather, palladium hardware, waiting list exclusive',
                'price' => 25000.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Ferrari 488 GTB',
                'description' => '3.9L twin-turbo V8, 661hp, Italian craftsmanship at its peak',
                'price' => 262000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Patek Philippe Nautilus',
                'description' => 'Steel sports watch, integrated bracelet, Geneva seal certification',
                'price' => 80000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Audemars Piguet Royal Oak',
                'description' => 'Octagonal bezel, Grande Tapisserie dial, integrated bracelet',
                'price' => 32000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1594576722512-582bcd46fba4?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Lamborghini Huracán STO',
                'description' => 'Track-focused supercar, naturally aspirated V10, aerodynamic excellence',
                'price' => 331000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1621135802920-133df287f89c?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Chanel Classic Flap Bag',
                'description' => 'Quilted lambskin, gold hardware, timeless French elegance',
                'price' => 8800.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Richard Mille RM 11-03',
                'description' => 'Carbon fiber case, flyback chronograph, Formula 1 inspired',
                'price' => 195000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1509048191080-d2ccafd5d7ae?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Louis Vuitton Neverfull MM',
                'description' => 'Monogram canvas, leather trim, versatile luxury tote',
                'price' => 1760.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1566150905458-1bf1fc113f0d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Porsche 911 Turbo S',
                'description' => 'Twin-turbo flat-six, all-wheel drive, German engineering perfection',
                'price' => 207000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1610768764270-790fbec18178?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Cartier Santos-Dumont',
                'description' => 'Square case, Roman numerals, aviation heritage design',
                'price' => 18500.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bottega Veneta Pouch',
                'description' => 'Intrecciato weave, buttery soft leather, minimalist luxury',
                'price' => 1650.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1555274175-6cbf6f3b137b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'McLaren 720S',
                'description' => 'Carbon fiber monocoque, 710hp twin-turbo V8, British engineering',
                'price' => 299000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Omega Speedmaster Professional',
                'description' => 'Moon watch, manual wind, space exploration heritage',
                'price' => 6350.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Gucci Jackie 1961',
                'description' => 'Hobo silhouette, bamboo handle, Italian luxury craftsmanship',
                'price' => 3200.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop&q=60',
                'is_vip_exclusive' => true
            ],

            // REGULAR CONSUMER PRODUCTS - DIFFERENT IMAGES
            [
                'name' => 'MacBook Pro 16" M3 Max',
                'description' => 'Apple Silicon M3 Max chip, 16GB RAM, 512GB SSD, Liquid Retina XDR display',
                'price' => 3199.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'iPhone 15 Pro Max',
                'description' => 'Titanium design, A17 Pro chip, 48MP main camera, 1TB storage',
                'price' => 1499.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Dyson V15 Detect',
                'description' => 'Laser dust detection, 60min runtime, powerful cordless vacuum',
                'price' => 749.00,
                'category' => 'Home Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'KitchenAid Artisan Stand Mixer',
                'description' => '5-quart bowl, 10 speeds, tilt-head design, iconic kitchen appliance',
                'price' => 379.00,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Peloton Bike+',
                'description' => 'Interactive fitness bike, rotating touchscreen, live classes',
                'price' => 2495.00,
                'category' => 'Fitness Equipment',
                'image_url' => 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Sony WH-1000XM5',
                'description' => 'Industry-leading noise cancellation, 30-hour battery, premium sound',
                'price' => 399.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Nespresso Vertuo Next',
                'description' => 'Centrifusion brewing, multiple cup sizes, premium coffee experience',
                'price' => 199.00,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Instant Pot Duo 7-in-1',
                'description' => 'Pressure cooker, slow cooker, rice cooker, all-in-one convenience',
                'price' => 129.00,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&auto=format&fit=crop&q=80',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Roomba j7+',
                'description' => 'Smart mapping, pet waste avoidance, automatic dirt disposal',
                'price' => 649.00,
                'category' => 'Home Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Tesla Model S Plaid',
                'description' => 'Tri-motor all-wheel drive, 1020hp, 405mi range, cutting-edge EV',
                'price' => 109990.00,
                'category' => 'Electric Vehicles',
                'image_url' => 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}