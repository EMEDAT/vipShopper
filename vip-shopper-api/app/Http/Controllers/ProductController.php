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
                // Show all products (regular + VIP)
            } else {
                $productLimit = 15; // Bronze/Silver users get 15 products
                $query->regular(); // Only non-VIP products
            }
        } else {
            $query->regular();
        }

        $products = $query->latest()->paginate($productLimit);

        return response()->json([
            'message' => 'Products retrieved successfully! 🛍️',
            'products' => $products,
            'product_limit' => $productLimit,
            'user_tier' => $user ? $user->vip_tier : 'guest'
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
        
        if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
            // Regular users: Show 15 VIP-only products as preview
            $vipProducts = Product::vipOnly()
                ->latest()
                ->paginate(15);

            return response()->json([
                'message' => "Limited VIP preview for {$user->name}! Upgrade for full access. 🔒",
                'products' => $vipProducts,
                'vip_tier' => $user->vip_tier,
                'product_limit' => 15,
                'access_level' => 'limited',
                'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier)
            ]);
        }

        // VIP users: Show 30 products - VIP products first, then regular products
        $vipProducts = Product::vipOnly()->latest()->get();
        $regularProducts = Product::regular()->latest()->get();
        
        // Combine: VIP products first, then regular products, limit to 30 total
        $allProducts = $vipProducts->concat($regularProducts)->take(30);
        
        // Convert to paginated response format
        $paginatedProducts = new \Illuminate\Pagination\LengthAwarePaginator(
            $allProducts,
            $allProducts->count(),
            30,
            1,
            ['path' => request()->url()]
        );

        return response()->json([
            'message' => "Welcome to VIP exclusives, {$user->name}! ✨",
            'products' => [
                'data' => $allProducts->values(),
                'total' => $allProducts->count(),
                'per_page' => 30,
                'current_page' => 1
            ],
            'vip_tier' => $user->vip_tier,
            'product_limit' => 30,
            'access_level' => 'full',
            'composition' => [
                'vip_exclusive' => $vipProducts->count(),
                'regular' => min($regularProducts->count(), 30 - $vipProducts->count())
            ]
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