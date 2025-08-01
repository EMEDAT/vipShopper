<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    public function run()
    {
        $products = [
            // VIP EXCLUSIVE - ULTRA LUXURY (30 items) - For rich people only!
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
                'image_url' => 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800&auto=format&fit=crop',
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
                'name' => 'Chanel Haute Couture Jacket',
                'description' => 'Hand-sewn tweed, Gabrielle Chanel design heritage, runway exclusive',
                'price' => 18500.00,
                'category' => 'Haute Couture',
                'image_url' => 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Lamborghini Huracán Performante',
                'description' => 'Naturally aspirated V10, ALA aerodynamics, Nürburgring record holder',
                'price' => 274000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Tiffany & Co. Soleste Ring',
                'description' => '2-carat round brilliant diamond, platinum setting, VVS1 clarity',
                'price' => 45000.00,
                'category' => 'Fine Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Porsche 911 Turbo S',
                'description' => 'Twin-turbo flat-six, PDK transmission, German precision engineering',
                'price' => 207000.00,
                'category' => 'Luxury Sports Cars',
                'image_url' => 'https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Van Cleef Alhambra Necklace',
                'description' => '20 motifs, 18k gold, mother-of-pearl inlay, French high jewelry',
                'price' => 15600.00,
                'category' => 'Fine Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1602173574767-37ac01994b2a?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Richard Mille RM 011',
                'description' => 'Titanium case, skeletonized movement, Formula 1 inspired design',
                'price' => 125000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1509048191080-d2e2678e3449?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bottega Veneta Jodie Bag',
                'description' => 'Signature intrecciato weave, buttery soft leather, Italian craftsmanship',
                'price' => 3200.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Aston Martin DB11',
                'description' => '5.2L twin-turbo V12, British luxury grand tourer, Bond heritage',
                'price' => 215000.00,
                'category' => 'Luxury Grand Tourers',
                'image_url' => 'https://images.unsplash.com/photo-1580274455191-1c62238fa333?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bulgari Serpenti Tubogas',
                'description' => 'Rose gold snake bracelet watch, iconic Italian design, flexible tubogas',
                'price' => 28000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1611652022419-a9419f74343d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Saint Laurent Le Smoking',
                'description' => 'Yves Saint Laurent iconic tuxedo, wool gabardine, runway heritage',
                'price' => 4900.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Chopard Happy Diamonds',
                'description' => 'Floating diamonds, 18k gold case, Swiss luxury movement',
                'price' => 22000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1549972574-8e3e1ed6a347?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bentley Continental GT',
                'description' => 'W12 engine, British handcrafted luxury, grand touring perfection',
                'price' => 235000.00,
                'category' => 'Luxury Grand Tourers',
                'image_url' => 'https://images.unsplash.com/photo-1449965408869-eaa3f722e40d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Hermès Kelly 28cm',
                'description' => 'Epsom leather, turn-lock closure, Grace Kelly heritage design',
                'price' => 28000.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1590736969955-71cc94901144?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Rolls-Royce Wraith',
                'description' => 'V12 luxury coupe, starlight headliner, bespoke British craftsmanship',
                'price' => 330000.00,
                'category' => 'Ultra-Luxury Cars',
                'image_url' => 'https://images.unsplash.com/photo-1563720223185-11003d516935?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Cartier Panthère de Cartier',
                'description' => 'Yellow gold case, diamond accents, iconic panther motif',
                'price' => 24000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Louis Vuitton Capucines MM',
                'description' => 'Taurillon leather, LV closure, French leather craftsmanship',
                'price' => 5200.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'McLaren 720S',
                'description' => '4.0L twin-turbo V8, carbon fiber monocoque, British supercar excellence',
                'price' => 299000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Vacheron Constantin Patrimony',
                'description' => 'Manual winding, ultra-thin movement, Geneva hallmark',
                'price' => 35000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Goyard Saint-Louis PM',
                'description' => 'Hand-painted chevron canvas, French luxury trunk maker heritage',
                'price' => 1890.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1591561954557-26941169b49e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Bugatti Chiron Sport',
                'description' => 'Quad-turbo W16, 1479hp, 300mph+ capability, ultimate hypercar',
                'price' => 3000000.00,
                'category' => 'Hypercars',
                'image_url' => 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Omega Speedmaster Professional',
                'description' => 'Moonwatch heritage, manual winding, NASA flight-qualified',
                'price' => 6350.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1522312346375-d1a52e2b99b3?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Dior Lady Dior',
                'description' => 'Cannage quilting, Dior charms, Princess Diana heritage design',
                'price' => 4400.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1566150905458-1bf1fc113f0d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Maserati MC20',
                'description' => 'V6 Nettuno engine, Italian supercar, carbon fiber construction',
                'price' => 216000.00,
                'category' => 'Supercars',
                'image_url' => 'https://images.unsplash.com/photo-1610768764270-790fbec18178?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Jaeger-LeCoultre Reverso',
                'description' => 'Art Deco design, reversible case, Swiss manufacture movement',
                'price' => 18200.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Prada Re-Edition 2005',
                'description' => 'Tessuto nylon, vintage-inspired, Italian minimalist design',
                'price' => 1200.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],

            // REGULAR CONSUMER PRODUCTS (15 items) - For normal people
            [
                'name' => 'MacBook Pro 16" M3 Max',
                'description' => 'Apple Silicon M3 Max chip, 16GB RAM, 512GB SSD, Liquid Retina XDR',
                'price' => 2499.00,
                'category' => 'Laptops',
                'image_url' => 'https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'iPhone 15 Pro Max',
                'description' => 'Titanium build, A17 Pro chip, 256GB storage, Pro camera system',
                'price' => 1199.00,
                'category' => 'Smartphones',
                'image_url' => 'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Sony WH-1000XM5',
                'description' => 'Premium noise canceling headphones, 30hr battery, multipoint Bluetooth',
                'price' => 349.00,
                'category' => 'Audio',
                'image_url' => 'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Tesla Model 3 Performance',
                'description' => 'Dual motor AWD, 315mi range, autopilot, premium interior',
                'price' => 52990.00,
                'category' => 'Electric Vehicles',
                'image_url' => 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Nike Air Jordan 1 Retro High',
                'description' => 'Premium leather construction, iconic colorway, basketball heritage',
                'price' => 170.00,
                'category' => 'Sneakers',
                'image_url' => 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Chanel No. 5 Eau de Parfum',
                'description' => '100ml bottle, iconic fragrance, aldehydic floral composition',
                'price' => 185.00,
                'category' => 'Fragrances',
                'image_url' => 'https://images.unsplash.com/photo-1541643600914-78b084683601?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Seiko Prospex Solar Diver',
                'description' => 'Solar movement, 200m water resistance, unidirectional bezel',
                'price' => 195.00,
                'category' => 'Watches',
                'image_url' => 'https://images.unsplash.com/photo-1434493789847-2f02dc6ca35d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Vitamix 5200 Blender',
                'description' => '2HP motor, aircraft-grade stainless steel blades, 7-year warranty',
                'price' => 449.00,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1570197788417-0e82375c9371?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'BMW 3 Series 330i',
                'description' => '2.0L TwinPower Turbo, 8-speed automatic, luxury sedan',
                'price' => 43500.00,
                'category' => 'Luxury Sedans',
                'image_url' => 'https://images.unsplash.com/photo-1555215695-3004980ad54e?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Purple Hybrid Premier Mattress',
                'description' => 'Queen size, cooling gel grid, pressure relief, 100-night trial',
                'price' => 1799.00,
                'category' => 'Home & Sleep',
                'image_url' => 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Herman Miller Aeron Chair',
                'description' => 'Size B, fully loaded, ergonomic office seating, 12-year warranty',
                'price' => 1395.00,
                'category' => 'Office Furniture',
                'image_url' => 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Samsung 65" QN90A Neo QLED',
                'description' => '4K 120Hz, Quantum HDR 32X, Neo Quantum Processor, premium TV',
                'price' => 1797.00,
                'category' => 'Electronics',
                'image_url' => 'https://images.unsplash.com/photo-1593359677879-a4bb92f829d1?w=800&auto=format&fit=crop',
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
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}