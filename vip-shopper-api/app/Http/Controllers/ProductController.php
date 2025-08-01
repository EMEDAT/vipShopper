<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    /**
     * 🔥 CRITICAL FIX: Main products endpoint with explicit VIP filtering
     */
    public function index(Request $request)
    {
        $query = Product::query();
        $user = $request->user();
        
        $productLimit = 15; // Default for regular users
        
        if ($user) {
            if (in_array($user->vip_tier, ['gold', 'platinum'])) {
                $productLimit = 30; // VIP users get 30 products
                // VIP users see ALL products (regular + VIP) in main feed
                // CRITICAL FIX: Don't apply any filter - they see everything
            } else {
                $productLimit = 15; // Bronze/Silver users get 15 products
                // CRITICAL FIX: Ensure regular scope is applied with explicit where clause
                $query->where('is_vip_exclusive', false);
            }
        } else {
            // CRITICAL FIX: Guests see only regular products (explicit filter)
            $query->where('is_vip_exclusive', false);
        }

        $products = $query->latest()->paginate($productLimit);

        return response()->json([
            'message' => 'Products retrieved successfully! 🛍️',
            'products' => $products,
            'product_limit' => $productLimit,
            'user_tier' => $user ? $user->vip_tier : 'guest',
            'total_products' => $query->count(),
            'debug_info' => [
                'user_has_vip_access' => $user ? in_array($user->vip_tier, ['gold', 'platinum']) : false,
                'query_applied_vip_filter' => !($user && in_array($user->vip_tier, ['gold', 'platinum'])),
                'vip_products_total' => Product::where('is_vip_exclusive', true)->count(),
                'regular_products_total' => Product::where('is_vip_exclusive', false)->count(),
            ]
        ]);
    }

    /**
     * 🔥 CRITICAL FIX: VIP products endpoint with bulletproof access control
     */
    public function vipProducts(Request $request)
    {
        $user = $request->user();
        
        // Check if user is logged in
        if (!$user) {
            return response()->json([
                'message' => '🔒 Please login to access VIP products',
                'products' => [],
                'access_level' => 'denied',
                'vip_tier' => 'guest',
                'product_limit' => 0,
                'total_vip_products' => Product::where('is_vip_exclusive', true)->count()
            ], 401);
        }
        
        // CRITICAL FIX: Regular users get ZERO products with proper error response
        if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
            return response()->json([
                'message' => "🔒 Upgrade to Gold or Platinum to access VIP products! Currently {$user->vip_tier} tier.",
                'products' => [], // EMPTY ARRAY - NO PRODUCTS FOR REGULAR USERS
                'vip_tier' => $user->vip_tier,
                'product_limit' => 0,
                'access_level' => 'denied',
                'total_vip_products' => Product::where('is_vip_exclusive', true)->count(),
                'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier)
            ], 403); // Return 403 status code
        }

        // VIP users: ALL VIP-exclusive products
        $vipProducts = Product::where('is_vip_exclusive', true)
            ->latest()
            ->paginate(30);

        return response()->json([
            'message' => "Welcome to VIP exclusives, {$user->name}! ✨",
            'products' => $vipProducts,
            'vip_tier' => $user->vip_tier,
            'product_limit' => 30,
            'access_level' => 'full',
            'exclusive_count' => Product::where('is_vip_exclusive', true)->count(),
            'debug_info' => [
                'user_tier' => $user->vip_tier,
                'has_vip_access' => true,
                'products_returned' => $vipProducts->count()
            ]
        ]);
    }

    /**
     * 🔥 CRITICAL FIX: Individual product access with VIP enforcement
     */
    public function show($id, Request $request)
    {
        $product = Product::findOrFail($id);
        
        // CRITICAL FIX: Enforce VIP access for individual product viewing
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
                    ],
                    'access_level' => 'denied'
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
                        'price_preview' => 'Premium pricing',
                        'current_tier' => $user->vip_tier
                    ],
                    'upgrade_benefits' => $this->getUpgradeBenefits($user->vip_tier),
                    'access_level' => 'denied'
                ], 403);
            }
        }

        return response()->json([
            'message' => 'Product details retrieved! 💎',
            'product' => $product,
            'vip_status' => $product->is_vip_exclusive ? '✨ VIP Exclusive' : '🛍️ Available to all',
            'access_level' => 'full'
        ]);
    }

    /**
     * 🔥 IMPROVED: Regular products endpoint (public access)
     */
    public function regularProducts(Request $request)
    {
        $products = Product::where('is_vip_exclusive', false)
            ->latest()
            ->paginate(15);

        return response()->json([
            'message' => 'Regular products retrieved! 🛍️',
            'products' => $products,
            'product_limit' => 15,
            'access_level' => 'public',
            'total_regular_products' => Product::where('is_vip_exclusive', false)->count(),
            'debug_info' => [
                'only_regular_products' => true,
                'vip_products_excluded' => true
            ]
        ]);
    }

    /**
     * 🔥 ENHANCED: Upgrade benefits helper with detailed information
     */
    private function getUpgradeBenefits($currentTier)
    {
        $upgrades = [
            'bronze' => [
                'next_tier' => 'Silver',
                'benefits' => [
                    '10% cashback on all purchases',
                    'Free shipping on orders over $50',
                    'Priority customer support',
                    'Early access to sales'
                ],
                'spend_required' => '$1,000 total spending',
                'current_benefits' => [
                    '5% cashback on purchases',
                    'Free shipping over $100'
                ]
            ],
            'silver' => [
                'next_tier' => 'Gold', 
                'benefits' => [
                    '15% cashback on all purchases',
                    'Access to VIP exclusive products',
                    'Personal shopper consultations',
                    'Free express shipping',
                    'Exclusive member events'
                ],
                'spend_required' => '$5,000 total spending',
                'current_benefits' => [
                    '10% cashback on purchases',
                    'Free shipping',
                    'Priority support'
                ]
            ],
            'gold' => [
                'next_tier' => 'Platinum',
                'benefits' => [
                    '20% cashback on all purchases',
                    'Early access to new product releases',
                    'Dedicated personal shopper service',
                    'Premium gift wrapping',
                    'VIP customer hotline'
                ],
                'spend_required' => '$15,000 total spending',
                'current_benefits' => [
                    '15% cashback on purchases',
                    'VIP exclusive products access',
                    'Personal shopper consultations'
                ]
            ],
            'platinum' => [
                'next_tier' => null, // Already at highest tier
                'benefits' => [
                    'Maximum tier achieved!',
                    'All premium benefits unlocked'
                ],
                'spend_required' => null,
                'current_benefits' => [
                    '20% cashback on purchases',
                    'All VIP exclusive products',
                    'Dedicated personal shopper',
                    'Premium member perks'
                ]
            ]
        ];

        return $upgrades[$currentTier] ?? [
            'next_tier' => 'Silver',
            'benefits' => ['Upgrade to unlock more benefits'],
            'spend_required' => 'Contact support for details'
        ];
    }

    /**
     * 🔥 NEW: Debug endpoint to check VIP filtering (remove in production)
     */
    public function debug(Request $request)
    {
        if (!app()->environment('local')) {
            abort(404);
        }

        $user = $request->user();
        
        return response()->json([
            'user' => $user ? [
                'id' => $user->id,
                'name' => $user->name,
                'vip_tier' => $user->vip_tier,
                'has_vip_access' => in_array($user->vip_tier, ['gold', 'platinum'])
            ] : null,
            'products' => [
                'total' => Product::count(),
                'regular' => Product::where('is_vip_exclusive', false)->count(),
                'vip_only' => Product::where('is_vip_exclusive', true)->count(),
            ],
            'scopes_test' => [
                'regular_scope' => Product::where('is_vip_exclusive', false)->pluck('name'),
                'vip_scope' => Product::where('is_vip_exclusive', true)->pluck('name'),
            ]
        ]);
    }
}