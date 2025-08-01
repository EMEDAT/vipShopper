<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $query = Product::query();
        $user = $request->user();
        
        $productLimit = 15; // Default for regular users
        
        if ($user) {
            if (in_array($user->vip_tier, ['gold', 'platinum'])) {
                $productLimit = 30; // VIP users get 30 products
                // VIP users see ALL products (regular + VIP) in main feed
            } else {
                $productLimit = 15; // Bronze/Silver users get 15 products
                $query->regular(); // Only non-VIP products
            }
        } else {
            $query->regular(); // Guests see only regular products
        }

        $products = $query->latest()->paginate($productLimit);

        return response()->json([
            'message' => 'Products retrieved successfully! 🛍️',
            'products' => $products,
            'product_limit' => $productLimit,
            'user_tier' => $user ? $user->vip_tier : 'guest',
            'total_products' => $query->count()
        ]);
    }

    public function vipProducts(Request $request)
    {
        $user = $request->user();
        
        if (!$user) {
            return response()->json([
                'message' => '🔒 Please login to access VIP products',
                'products' => [],
                'access_level' => 'denied'
            ], 401);
        }
        
        // CRITICAL FIX: Regular users get ZERO products, no preview
        if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
            return response()->json([
                'message' => "🔒 Upgrade to Gold or Platinum to access VIP products! Currently {$user->vip_tier} tier.",
                'products' => [], // EMPTY - NO PRODUCTS FOR REGULAR USERS
                'vip_tier' => $user->vip_tier,
                'product_limit' => 0,
                'access_level' => 'denied',
                'total_vip_products' => Product::vipOnly()->count(),
                'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier)
            ], 403);
        }

        // VIP users: ALL VIP-exclusive products
        $vipProducts = Product::vipOnly()
            ->latest()
            ->paginate(30);

        return response()->json([
            'message' => "Welcome to VIP exclusives, {$user->name}! ✨",
            'products' => $vipProducts,
            'vip_tier' => $user->vip_tier,
            'product_limit' => 30,
            'access_level' => 'full',
            'exclusive_count' => Product::vipOnly()->count()
        ]);
    }

    public function show($id, Request $request)
    {
        $product = Product::findOrFail($id);
        
        if ($product->is_vip_exclusive) {
            if (!$request->user()) {
                return response()->json([
                    'message' => '🔒 Please login to access VIP products',
                    'product' => [
                        'id' => $product->id,
                        'name' => $product->name,
                        'category' => $product->category,
                        'is_vip_exclusive' => true,
                        'preview_message' => '✨ This is a VIP exclusive product. Login to see details!'
                    ]
                ], 403);
            }

            $user = $request->user();
            if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
                return response()->json([
                    'message' => '🔒 Upgrade to Gold or Platinum to access this VIP product',
                    'product' => [
                        'id' => $product->id,
                        'name' => $product->name,
                        'category' => $product->category,
                        'is_vip_exclusive' => true,
                        'required_tier' => 'Gold or Platinum',
                        'price_preview' => 'Premium pricing'
                    ],
                    'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier)
                ], 403);
            }
        }

        return response()->json([
            'message' => 'Product details retrieved! 💎',
            'product' => $product,
            'vip_status' => $product->is_vip_exclusive ? '✨ VIP Exclusive' : '🛍️ Available to all'
        ]);
    }

    public function regularProducts(Request $request)
    {
        $products = Product::regular()
            ->latest()
            ->paginate(15);

        return response()->json([
            'message' => 'Regular products retrieved! 🛍️',
            'products' => $products,
            'product_limit' => 15,
            'access_level' => 'public',
            'total_regular_products' => Product::regular()->count()
        ]);
    }

    private function getUpgradeBenefits($currentTier)
    {
        $upgrades = [
            'bronze' => [
                'next_tier' => 'Silver',
                'benefits' => ['10% cashback', 'Free shipping', 'Priority support'],
                'spend_required' => '$1,000 total spending'
            ],
            'silver' => [
                'next_tier' => 'Gold', 
                'benefits' => ['15% cashback', 'VIP exclusive products', 'Personal shopper consultations'],
                'spend_required' => '$5,000 total spending'
            ],
            'gold' => [
                'next_tier' => 'Platinum',
                'benefits' => ['20% cashback', 'Early access to new releases', 'Personal shopper service'],
                'spend_required' => '$15,000 total spending'
            ]
        ];

        return $upgrades[$currentTier] ?? null;
    }
}