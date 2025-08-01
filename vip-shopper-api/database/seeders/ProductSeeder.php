<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Product;

class ProductSeeder extends Seeder
{
    public function run()
    {
        $products = [
            // VIP EXCLUSIVE - ULTRA LUXURY (22 items)
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
                'description' => 'Steel sports watch, Genta design, perpetual calendar complication',
                'price' => 87000.00,
                'category' => 'Luxury Watches',
                'image_url' => 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Cartier Love Bracelet',
                'description' => '18k yellow gold, screw motif, iconic oval shape, includes screwdriver',
                'price' => 7250.00,
                'category' => 'Fine Jewelry',
                'image_url' => 'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'Louis Vuitton Capucines MM',
                'description' => 'Epi leather, LV turn-lock closure, named after street where LV opened',
                'price' => 5100.00,
                'category' => 'Luxury Fashion',
                'image_url' => 'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => true
            ],
            [
                'name' => 'McLaren 720S',
                'description' => 'Carbon fiber monocoque, 710hp twin-turbo V8, active aerodynamics',
                'price' => 299000.00,
                'category' => 'Supercars',
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

            // REGULAR CONSUMER PRODUCTS (28 items)
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
                'name' => 'Canon EOS R5',
                'description' => '45MP full-frame mirrorless, 8K video, in-body stabilization',
                'price' => 3899.00,
                'category' => 'Cameras',
                'image_url' => 'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Samsung Galaxy S24 Ultra',
                'description' => '200MP camera, S Pen, 1TB storage, Snapdragon 8 Gen 3',
                'price' => 1299.00,
                'category' => 'Smartphones',
                'image_url' => 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Apple Watch Series 9',
                'description' => 'S9 SiP, Always-On Retina display, health monitoring, GPS + Cellular',
                'price' => 429.00,
                'category' => 'Smartwatches',
                'image_url' => 'https://images.unsplash.com/photo-1551816230-ef5deaed4a26?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Adidas Ultraboost 23',
                'description' => 'BOOST midsole, Primeknit upper, continental rubber outsole',
                'price' => 190.00,
                'category' => 'Running Shoes',
                'image_url' => 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Dyson V15 Detect',
                'description' => 'Laser dust detection, 60min runtime, whole-machine HEPA filtration',
                'price' => 749.00,
                'category' => 'Home Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Levi\'s 501 Original Jeans',
                'description' => 'Straight leg, button fly, 100% cotton denim, classic fit',
                'price' => 98.00,
                'category' => 'Clothing',
                'image_url' => 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Bose QuietComfort 45',
                'description' => 'Wireless noise canceling, 24hr battery, TriPort acoustic design',
                'price' => 329.00,
                'category' => 'Audio',
                'image_url' => 'https://images.unsplash.com/photo-1484704849700-f032a568e944?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'KitchenAid Artisan Stand Mixer',
                'description' => '5-quart bowl, 10 speeds, tilt-head design, dishwasher-safe',
                'price' => 429.00,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1586201375761-83865001e31c?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Ray-Ban Aviator Classic',
                'description' => 'Gold-tone frame, green G-15 lenses, 100% UV protection',
                'price' => 154.00,
                'category' => 'Sunglasses',
                'image_url' => 'https://images.unsplash.com/photo-1511499767150-a48a237f0083?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Nintendo Switch OLED',
                'description' => '7" OLED screen, enhanced audio, 64GB storage, portable gaming',
                'price' => 349.00,
                'category' => 'Gaming',
                'image_url' => 'https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Hydro Flask Water Bottle',
                'description' => '32oz, double-wall vacuum insulation, 18/8 stainless steel',
                'price' => 44.95,
                'category' => 'Outdoor Gear',
                'image_url' => 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Patagonia Houdini Jacket',
                'description' => 'Lightweight windbreaker, DWR finish, packable design',
                'price' => 129.00,
                'category' => 'Outdoor Clothing',
                'image_url' => 'https://images.unsplash.com/photo-1544966503-7cc5ac882d5a?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Instant Pot Duo 7-in-1',
                'description' => '8-quart capacity, pressure cooker, slow cooker, rice cooker',
                'price' => 119.00,
                'category' => 'Kitchen Appliances',
                'image_url' => 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Allbirds Tree Runners',
                'description' => 'Eucalyptus tree fiber, machine washable, carbon neutral shipping',
                'price' => 98.00,
                'category' => 'Sustainable Footwear',
                'image_url' => 'https://images.unsplash.com/photo-1460353581641-37baddab0fa2?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Yeti Rambler Tumbler',
                'description' => '20oz, double-wall vacuum insulation, MagSlider lid',
                'price' => 35.00,
                'category' => 'Drinkware',
                'image_url' => 'https://images.unsplash.com/photo-1544966503-7cc5ac882d5a?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Fitbit Charge 6',
                'description' => 'GPS fitness tracker, heart rate monitoring, 7-day battery',
                'price' => 199.00,
                'category' => 'Fitness Trackers',
                'image_url' => 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'iPad Air 5th Generation',
                'description' => 'M1 chip, 10.9" Liquid Retina display, 256GB WiFi',
                'price' => 749.00,
                'category' => 'Tablets',
                'image_url' => 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=800&auto=format&fit=crop',
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
                'name' => 'Casper Wave Hybrid Mattress',
                'description' => 'Queen size, zoned support, cooling gel pods, 100-night trial',
                'price' => 2095.00,
                'category' => 'Home & Sleep',
                'image_url' => 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ],
            [
                'name' => 'Herman Miller Aeron Chair',
                'description' => 'Size B, fully loaded, ergonomic office seating, 12-year warranty',
                'price' => 1395.00,
                'category' => 'Office Furniture',
                'image_url' => 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800&auto=format&fit=crop',
                'is_vip_exclusive' => false
            ]
        ];

        foreach ($products as $product) {
            Product::create($product);
        }
    }
}