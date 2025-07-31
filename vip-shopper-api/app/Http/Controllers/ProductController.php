<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        // Public endpoint - only show non-VIP products to non-authenticated users
        $query = Product::query();
        
        // If user is authenticated, show based on their VIP tier
        if ($request->user()) {
            $user = $request->user();
            
            // VIP users can see all products
            if (in_array($user->vip_tier, ['gold', 'platinum'])) {
                // No filter - show all products including VIP
            } else {
                // Bronze/Silver users see non-VIP products only
                $query->regular();
            }
        } else {
            // Non-authenticated users only see regular products
            $query->regular();
        }

        $products = $query->latest()->paginate(12);

        return response()->json([
            'message' => 'Products retrieved successfully! 🛍️',
            'products' => $products,
            'vip_message' => $request->user() && in_array($request->user()->vip_tier, ['gold', 'platinum']) 
                ? '✨ VIP Exclusive products included!' 
                : '🔒 Upgrade to Gold/Platinum to see exclusive VIP products!'
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
        
        // Check if user has VIP access
        if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
            return response()->json([
                'message' => '🔒 VIP access required for exclusive products',
                'current_tier' => $user->vip_tier,
                'required_tier' => 'Gold or Platinum',
                'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier)
            ], 403);
        }

        $vipProducts = Product::vipOnly()
            ->latest()
            ->paginate(12);

        return response()->json([
            'message' => "Welcome to VIP exclusives, {$user->name}! ✨",
            'products' => $vipProducts,
            'vip_tier' => $user->vip_tier,
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