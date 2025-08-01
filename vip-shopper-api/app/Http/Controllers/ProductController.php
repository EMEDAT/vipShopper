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
        
        // Determine product limit based on user tier
        $productLimit = 15; // Default for regular users
        
        if ($user) {
            if (in_array($user->vip_tier, ['gold', 'platinum'])) {
                $productLimit = 30; // VIP users get 30 products
                // No filter - show all products including VIP
            } else {
                $productLimit = 15; // Bronze/Silver users get 15 products
                $query->regular(); // Only non-VIP products
            }
        } else {
            // Non-authenticated users get 15 regular products
            $query->regular();
        }

        $products = $query->latest()->paginate($productLimit);

        return response()->json([
            'message' => 'Products retrieved successfully! 🛍️',
            'products' => $products,
            'product_limit' => $productLimit,
            'user_tier' => $user ? $user->vip_tier : 'guest',
            'vip_message' => $user && in_array($user->vip_tier, ['gold', 'platinum']) 
                ? "✨ VIP Exclusive products included! Showing $productLimit products." 
                : "🔒 Showing $productLimit products. Upgrade to Gold/Platinum for 30 products and VIP exclusives!"
        ]);
    }

    public function show($id, Request $request)
    {
        $product = Product::findOrFail($id);
        
        // Check VIP access for exclusive products
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
                        'required_tier' => 'Gold or Platinum'
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

    public function vipProducts(Request $request)
    {
        $user = $request->user();
        
        // Determine VIP product limit
        $vipLimit = in_array($user->vip_tier, ['gold', 'platinum']) ? 30 : 15;
        
        // Check if user has VIP access
        if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
            // Limited access - show some VIP products but with limited count
            $vipProducts = Product::vipOnly()
                ->latest()
                ->paginate($vipLimit);

            return response()->json([
                'message' => "Limited VIP preview for {$user->name}! Upgrade for full access. 🔒",
                'products' => $vipProducts,
                'vip_tier' => $user->vip_tier,
                'product_limit' => $vipLimit,
                'access_level' => 'limited',
                'exclusive_count' => Product::vipOnly()->count(),
                'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier)
            ]);
        }

        // Full VIP access
        $vipProducts = Product::vipOnly()
            ->latest()
            ->paginate($vipLimit);

        return response()->json([
            'message' => "Welcome to VIP exclusives, {$user->name}! ✨",
            'products' => $vipProducts,
            'vip_tier' => $user->vip_tier,
            'product_limit' => $vipLimit,
            'access_level' => 'full',
            'exclusive_count' => Product::vipOnly()->count()
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