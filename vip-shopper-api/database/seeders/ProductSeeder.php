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
            // ===============================
            // VIP EXCLUSIVE PRODUCTS (30 ULTRA-LUXURY ITEMS)
            // ===============================
            
            // LUXURY WATCHES (10 items)
            [
                'name' => 'Rolex Submariner Date',
                'description' => 'Swiss luxury diving watch, 904L steel, ceramic bezel, COSC certified',
                'price' => 13450.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1547996160-81dfa63595aa?w=800&auto=format&fit=crop',
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
                'name' => 'Richard Mille RM 11-03',
                'description' => 'Carbon fiber case, flyback chronograph, Formula 1 inspired',
                'price' => 195000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1509048191080-d2ccafd5d7ae?w=800&auto=format&fit=crop',
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
                'name' => 'Omega Speedmaster Professional',
                'description' => 'Moon watch, manual wind, space exploration heritage',
                'price' => 6350.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Jaeger-LeCoultre Reverso',
                'description' => 'Art Deco design, reversible case, Swiss manufacture movement',
                'price' => 24800.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Breitling Navitimer',
                'description' => 'Aviation chronograph, slide rule bezel, pilot heritage',
                'price' => 8200.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1586648179125-af0d1e75fc8e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'IWC Portuguese Chronograph',
                'description' => 'Classic design, in-house movement, Portuguese heritage',
                'price' => 12400.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Vacheron Constantin Overseas',
                'description' => 'Sports luxury watch, interchangeable straps, Geneva Seal',
                'price' => 28900.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],

            // SUPERCARS (10 items)
            [
                'name' => 'Ferrari 488 GTB',
                'description' => '3.9L twin-turbo V8, 661hp, Italian craftsmanship at its peak',
                'price' => 262000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1583121274602-3e2820c69888?w=800&auto=format&fit=crop',
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
                'name' => 'Porsche 911 Turbo S',
                'description' => 'Twin-turbo flat-six, all-wheel drive, German engineering perfection',
                'price' => 207000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1610768764270-790fbec18178?w=800&auto=format&fit=crop',
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
                'name' => 'Aston Martin DB11',
                'description' => 'Grand tourer, twin-turbo V8, British luxury and performance',
                'price' => 205000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bentley Continental GT',
                'description' => 'Luxury grand tourer, W12 engine, handcrafted British elegance',
                'price' => 218000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Maserati MC20',
                'description' => 'V6 Nettuno engine, Italian supercar, carbon fiber construction',
                'price' => 216000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1503736334956-4c8f8e92946d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Koenigsegg Regera',
                'description' => 'Hybrid drivetrain, 1500hp, Swedish hypercar innovation',
                'price' => 1900000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bugatti Chiron',
                'description' => 'Quad-turbo W16, 1479hp, ultimate luxury hypercar',
                'price' => 3000000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1544829099-b9a0c5303bea?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Rolls-Royce Cullinan',
                'description' => 'Ultra-luxury SUV, V12 engine, ultimate comfort and prestige',
                'price' => 330000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&auto=format&fit=crop&q=60',
                'is_vip_exclusive' => true
            ],

            // LUXURY FASHION (10 items)
            [
                'name' => 'Hermès Birkin 35cm',
                'description' => 'Handcrafted Togo leather, palladium hardware, waiting list exclusive',
                'price' => 25000.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop',
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
                'name' => 'Louis Vuitton Neverfull MM',
                'description' => 'Monogram canvas, leather trim, versatile luxury tote',
                'price' => 1760.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1566150905458-1bf1fc113f0d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Dior Lady Dior',
                'description' => 'Cannage quilting, Dior charms, Princess Diana heritage design',
                'price' => 4400.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1555274175-6cbf6f3b137b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bottega Veneta Pouch',
                'description' => 'Intrecciato weave, buttery soft leather, minimalist luxury',
                'price' => 1650.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop&q=80',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Gucci Jackie 1961',
                'description' => 'Hobo silhouette, bamboo handle, Italian luxury craftsmanship',
                'price' => 3200.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1591348122403-47c467d2a5b4?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Prada Re-Edition 2005',
                'description' => 'Tessuto nylon, vintage-inspired, Italian minimalist design',
                'price' => 1200.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1590739020135-6c80fe6b027e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Balenciaga City Bag',
                'description' => 'Distressed leather, motorcycle-inspired, Spanish fashion house',
                'price' => 1850.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1594223274512-ad4803739b7c?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Saint Laurent Kate Bag',
                'description' => 'Grain de poudre leather, chain strap, Parisian chic',
                'price' => 1890.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1520975916090-3105956dac38?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Goyard Saint Louis Tote',
                'description' => 'Hand-painted monogram, French heritage, artisanal craftsmanship',
                'price' => 1680.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop&q=70',
                'is_vip_exclusive' => true
            ],

            // ===============================
            // REGULAR PRODUCTS (12 AFFORDABLE EVERYDAY ITEMS)
            // ===============================
            
            [
                'name' => 'Nike Air Force 1 Sneakers',
                'description' => 'Classic white sneakers, comfortable daily wear, iconic design',
                'price' => 90.00,
                'category' => 'Shoes',
                'image_url' => 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Adidas Originals Hoodie',
                'description' => 'Cotton blend hoodie, comfortable fit, everyday casual wear',
                'price' => 65.00,
                'category' => 'Clothing',
                'image_url' => 'https://images.unsplash.com/photo-1556821840-3a9b50f5b41b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Levi\'s 501 Original Jeans',
                'description' => 'Classic straight fit denim, button fly, timeless American style',
                'price' => 89.50,
                'category' => 'Clothing',
                'image_url' => 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Sony WH-CH720N Headphones',
                'description' => 'Noise canceling, 35-hour battery, affordable audio quality',
                'price' => 149.99,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Hamilton Beach Coffee Maker',
                'description' => '12-cup programmable coffee maker, auto shut-off, affordable brewing',
                'price' => 49.99,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Ninja Personal Blender',
                'description' => 'Single-serve blender, 18oz cup, perfect for smoothies',
                'price' => 79.99,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Anker Portable Charger',
                'description' => '10000mAh power bank, fast charging, compact travel companion',
                'price' => 25.99,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1609592419017-ba7294e40f8e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'IKEA Friheten Sofa Bed',
                'description' => 'Convertible sofa with storage, affordable furniture solution',
                'price' => 499.00,
                'category' => 'Furniture',
                'image_url' => 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Cuisinart Non-Stick Pan Set',
                'description' => '10-piece cookware set, dishwasher safe, everyday cooking essentials',
                'price' => 199.99,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Target Goodfellow T-Shirts (3-Pack)',
                'description' => 'Basic cotton t-shirts, comfortable fit, affordable basics',
                'price' => 15.00,
                'category' => 'Clothing',
                'image_url' => 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Black+Decker Toaster Oven',
                'description' => '4-slice capacity, affordable kitchen convenience, basic functions',
                'price' => 39.99,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1585515656862-f7736959db89?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Walmart Great Value Backpack',
                'description' => 'Durable school/work backpack, multiple compartments, budget-friendly',
                'price' => 19.97,
                'category' => 'Accessories',
                'image_url' => 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop&q=90',
                'is_vip_exclusive' => false
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}