<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class AIController extends Controller
{
    public function search(Request $request)
    {
        $request->validate([
            'query' => 'required|string|max:255'
        ]);

        $query = $request->input('query');
        
        // AI-powered product search using natural language
        $products = $this->aiProductSearch($query, $request->user());
        
        return response()->json([
            'message' => "AI found products for: '{$query}' 🤖",
            'query' => $query,
            'products' => $products,
            'ai_insights' => $this->generateSearchInsights($query, $products->count())
        ]);
    }

    public function recommendations(Request $request)
    {
        $user = $request->user();
        
        // AI recommendations based on VIP tier and preferences
        $recommendations = $this->aiGenerateRecommendations($user);
        
        return response()->json([
            'message' => "Personalized recommendations for {$user->name} ✨",
            'recommendations' => $recommendations,
            'vip_tier' => $user->vip_tier,
            'ai_reasoning' => $this->getRecommendationReasoning($user)
        ]);
    }

    public function chat(Request $request)
    {
        $request->validate([
            'message' => 'required|string|max:500'
        ]);

        $user = $request->user();
        $message = $request->input('message');
        
        // AI concierge chat for VIP customers
        $response = $this->aiConciergeChat($message, $user);
        
        return response()->json([
            'message' => 'AI Concierge response 🤵‍♂️',
            'user_message' => $message,
            'ai_response' => $response,
            'vip_tier' => $user->vip_tier
        ]);
    }

    private function aiProductSearch($query, $user = null)
    {
        // Simulate AI-powered search logic
        $searchTerms = explode(' ', strtolower($query));
        
        $products = Product::query()
            ->where(function($q) use ($searchTerms) {
                foreach ($searchTerms as $term) {
                    $q->orWhere('name', 'like', "%{$term}%")
                      ->orWhere('description', 'like', "%{$term}%")
                      ->orWhere('category', 'like', "%{$term}%");
                }
            });

        // Apply VIP filtering
        if (!$user || !in_array($user->vip_tier, ['gold', 'platinum'])) {
            $products->regular();
        }

        return $products->take(6)->get();
    }

    private function aiGenerateRecommendations($user)
    {
        $baseQuery = Product::query();
        
        // VIP access check
        if (!in_array($user->vip_tier, ['gold', 'platinum'])) {
            $baseQuery->regular();
        }

        // AI logic based on user preferences and tier
        if ($user->preferences) {
            $preferences = $user->preferences;
            $recommendations = $baseQuery
                ->where(function($q) use ($preferences) {
                    foreach ($preferences as $pref) {
                        $q->orWhere('category', 'like', "%{$pref}%")
                          ->orWhere('name', 'like', "%{$pref}%");
                    }
                })
                ->take(4)
                ->get();
        } else {
            // Default recommendations based on VIP tier
            $recommendations = $baseQuery
                ->when($user->vip_tier === 'platinum', function($q) {
                    return $q->where('price', '>', 5000);
                })
                ->when($user->vip_tier === 'gold', function($q) {
                    return $q->where('price', '>', 1000);
                })
                ->take(4)
                ->get();
        }

        return $recommendations;
    }

    private function aiConciergeChat($message, $user)
    {
        $message = strtolower($message);
        
        // AI responses based on VIP tier and message content
        if (str_contains($message, 'recommend') || str_contains($message, 'suggest')) {
            return "As a {$user->vip_tier} member, I recommend checking our exclusive collection! Your spending power of $" . number_format($user->total_spent) . " qualifies you for premium selections. 💎";
        }
        
        if (str_contains($message, 'upgrade') || str_contains($message, 'tier')) {
            if ($user->vip_tier === 'platinum') {
                return "You're already at our highest tier! Enjoy unlimited access to all VIP exclusives. 👑";
            } else {
                $nextSpend = $this->getNextTierSpending($user->vip_tier);
                return "You're {$nextSpend} away from the next VIP tier! Upgrade to unlock exclusive products and higher cashback. ✨";
            }
        }
        
        if (str_contains($message, 'price') || str_contains($message, 'cost')) {
            return "As a {$user->vip_tier} member, you get " . $this->getCashbackRate($user->vip_tier) . " cashback on all purchases! Plus free shipping on everything. 🎁";
        }
        
        return "Hello {$user->name}! As your AI concierge, I'm here to help with product recommendations, VIP benefits, and exclusive access. What can I assist you with today? 🤖✨";
    }

    private function generateSearchInsights($query, $resultCount)
    {
        return [
            'results_found' => $resultCount,
            'search_type' => 'AI Natural Language Processing',
            'suggestion' => $resultCount === 0 
                ? "Try broader terms like 'luxury', 'electronics', or 'fashion'" 
                : "Refine your search with specific brands or price ranges"
        ];
    }

    private function getRecommendationReasoning($user)
    {
        return [
            'based_on' => [
                'vip_tier' => $user->vip_tier,
                'spending_history' => '$' . number_format($user->total_spent),
                'preferences' => $user->preferences ?? ['General luxury items']
            ],
            'ai_strategy' => 'Personalized curation based on VIP status and purchasing behavior'
        ];
    }

    private function getNextTierSpending($currentTier)
    {
        $thresholds = [
            'bronze' => '$500 more',
            'silver' => '$3,500 more', 
            'gold' => '$10,000 more'
        ];
        
        return $thresholds[$currentTier] ?? 'Maximum tier reached';
    }

    private function getCashbackRate($tier)
    {
        $rates = [
            'bronze' => '5%',
            'silver' => '10%',
            'gold' => '15%',
            'platinum' => '20%'
        ];
        
        return $rates[$tier] ?? '5%';
    }
}