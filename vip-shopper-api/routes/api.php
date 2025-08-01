<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\AIController;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Artisan;

// DEBUG ROUTES - REMOVE AFTER FIXING
Route::get('/debug-db', function() {
    try {
        // Check database connection
        DB::connection()->getPdo();
        
        // Check if users table exists
        $tableExists = Schema::hasTable('users');
        
        // Get all tables
        $tables = DB::select('SHOW TABLES');
        
        return response()->json([
            'database_connected' => true,
            'users_table_exists' => $tableExists,
            'all_tables' => $tables,
            'db_config' => [
                'connection' => config('database.default'),
                'host' => config('database.connections.mysql.host'),
                'database' => config('database.connections.mysql.database')
            ]
        ]);
        
    } catch (\Exception $e) {
        return response()->json([
            'database_connected' => false,
            'error' => $e->getMessage()
        ]);
    }
});

Route::get('/setup-products', function() {
    try {
        // Run the ProductSeeder
        Artisan::call('db:seed', [
            '--class' => 'ProductSeeder',
            '--force' => true
        ]);
        
        // Get count of products created
        $totalProducts = \App\Models\Product::count();
        $vipProducts = \App\Models\Product::where('is_vip_exclusive', true)->count();
        $regularProducts = \App\Models\Product::where('is_vip_exclusive', false)->count();
        
        return response()->json([
            'success' => true,
            'message' => 'Products seeded successfully',
            'products_created' => [
                'total' => $totalProducts,
                'vip_exclusive' => $vipProducts,
                'regular' => $regularProducts
            ],
            'seeder_output' => Artisan::output()
        ]);
        
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'error' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ], 500);
    }
});

Route::get('/fix-products', function() {
    try {
        // 1. Clear all existing products to remove duplicates
        \App\Models\Product::truncate();
        
        // 2. Run the updated ProductSeeder
        Artisan::call('db:seed', [
            '--class' => 'ProductSeeder',
            '--force' => true
        ]);
        
        // 3. Get detailed counts
        $totalProducts = \App\Models\Product::count();
        $vipProducts = \App\Models\Product::where('is_vip_exclusive', true)->count();
        $regularProducts = \App\Models\Product::where('is_vip_exclusive', false)->count();
        
        // 4. Verify no duplicate images
        $allImages = \App\Models\Product::pluck('image_url');
        $uniqueImages = $allImages->unique();
        $duplicateCount = $allImages->count() - $uniqueImages->count();
        
        // 5. Check price ranges to ensure proper separation
        $vipPriceRange = \App\Models\Product::where('is_vip_exclusive', true)
            ->selectRaw('MIN(price) as min_price, MAX(price) as max_price')
            ->first();
            
        $regularPriceRange = \App\Models\Product::where('is_vip_exclusive', false)
            ->selectRaw('MIN(price) as min_price, MAX(price) as max_price')
            ->first();
        
        // 6. Get sample products to verify
        $vipSample = \App\Models\Product::where('is_vip_exclusive', true)
            ->take(5)
            ->get(['name', 'price', 'category']);
            
        $regularSample = \App\Models\Product::where('is_vip_exclusive', false)
            ->take(5)
            ->get(['name', 'price', 'category']);
        
        return response()->json([
            'success' => true,
            'message' => '🎉 Products completely fixed! No duplicates, proper pricing!',
            'summary' => [
                'total_products' => $totalProducts,
                'vip_exclusive' => $vipProducts,
                'regular_affordable' => $regularProducts,
                'target_vip' => 30,
                'target_regular' => 12,
                'vip_goal_met' => $vipProducts >= 30,
                'regular_goal_met' => $regularProducts >= 12
            ],
            'image_verification' => [
                'total_images' => $allImages->count(),
                'unique_images' => $uniqueImages->count(),
                'duplicates_found' => $duplicateCount,
                'all_images_unique' => $duplicateCount === 0 ? '✅ Perfect!' : '❌ Still has duplicates'
            ],
            'price_analysis' => [
                'vip_price_range' => [
                    'min' => '$' . number_format($vipPriceRange->min_price, 2),
                    'max' => '$' . number_format($vipPriceRange->max_price, 2),
                    'category' => 'Ultra-Luxury'
                ],
                'regular_price_range' => [
                    'min' => '$' . number_format($regularPriceRange->min_price, 2),
                    'max' => '$' . number_format($regularPriceRange->max_price, 2),
                    'category' => 'Affordable Everyday'
                ],
                'proper_separation' => $regularPriceRange->max_price < 1000 ? '✅ Perfect separation!' : '⚠️ Check pricing'
            ],
            'product_samples' => [
                'vip_luxury_examples' => $vipSample,
                'regular_affordable_examples' => $regularSample
            ],
            'categories_breakdown' => [
                'vip_categories' => \App\Models\Product::where('is_vip_exclusive', true)
                    ->select('category')
                    ->groupBy('category')
                    ->pluck('category'),
                'regular_categories' => \App\Models\Product::where('is_vip_exclusive', false)
                    ->select('category')
                    ->groupBy('category')
                    ->pluck('category')
            ]
        ]);
        
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'error' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ], 500);
    }
});

Route::get('/setup-database', function() {
    try {
        // Check if tables exist, if not create them
        if (!Schema::hasTable('users')) {
            Artisan::call('migrate:fresh', ['--force' => true]);
            $migrationOutput = Artisan::output();
        }
        
        // Create VIP test user if doesn't exist
        $vipUser = \App\Models\User::updateOrCreate(
            ['email' => 'vip@example.com'],
            [
                'name' => 'VIP Customer',
                'password' => Hash::make('password'),
                'vip_tier' => 'platinum',
                'total_spent' => 25000.00,
                'preferences' => ['luxury_watches', 'designer_fashion']
            ]
        );
        
        // Create regular test user if doesn't exist  
        $regularUser = \App\Models\User::updateOrCreate(
            ['email' => 'customer@example.com'],
            [
                'name' => 'Regular Customer',
                'password' => Hash::make('password'), 
                'vip_tier' => 'bronze',
                'total_spent' => 500.00,
                'preferences' => ['basic']
            ]
        );
        
        return response()->json([
            'success' => true,
            'message' => 'Database setup completed',
            'users_created' => [
                'vip@example.com' => $vipUser->wasRecentlyCreated ? 'created' : 'updated',
                'customer@example.com' => $regularUser->wasRecentlyCreated ? 'created' : 'updated'
            ],
            'migration_output' => $migrationOutput ?? 'Tables already existed'
        ]);
        
    } catch (\Exception $e) {
        return response()->json([
            'success' => false,
            'error' => $e->getMessage(),
            'trace' => $e->getTraceAsString()
        ], 500);
    }
});

// Public routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

// Public product browsing 
Route::get('/products', [ProductController::class, 'index']); // Mixed products based on user tier
Route::get('/products/regular', [ProductController::class, 'regularProducts']); // Only regular products
// AI-powered search (public)
Route::post('/ai/search', [AIController::class, 'search']);

// Protected routes (require authentication)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'user']);
    
    // VIP product access - MUST BE BEFORE /products/{id}
    Route::get('/products/vip', [ProductController::class, 'vipProducts']); // ONLY VIP products
    
    // AI recommendations for logged-in users
    Route::post('/ai/recommendations', [AIController::class, 'recommendations']);
    Route::post('/ai/chat', [AIController::class, 'chat']);
});

// Individual product route - MUST BE LAST
Route::get('/products/{id}', [ProductController::class, 'show']);