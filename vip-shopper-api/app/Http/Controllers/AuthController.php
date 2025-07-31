<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'vip_tier' => 'bronze', // Default tier
            'total_spent' => 0,
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => 'Welcome to VIP Shopper! 🎉',
            'user' => $user,
            'token' => $token,
            'vip_benefits' => $this->getVipBenefits($user->vip_tier)
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!Auth::attempt($request->only('email', 'password'))) {
            throw ValidationException::withMessages([
                'email' => ['Invalid credentials'],
            ]);
        }

        $user = Auth::user();
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'message' => "Welcome back, {$user->name}! 🌟",
            'user' => $user,
            'token' => $token,
            'vip_status' => [
                'tier' => $user->vip_tier,
                'total_spent' => $user->total_spent,
                'benefits' => $this->getVipBenefits($user->vip_tier)
            ]
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Logged out successfully! Come back soon! 👋'
        ]);
    }

    public function user(Request $request)
    {
        return response()->json([
            'user' => $request->user(),
            'vip_status' => [
                'tier' => $request->user()->vip_tier,
                'total_spent' => $request->user()->total_spent,
                'benefits' => $this->getVipBenefits($request->user()->vip_tier)
            ]
        ]);
    }

    private function getVipBenefits($tier)
    {
        $benefits = [
            'bronze' => ['5% cashback', 'Free shipping over $100'],
            'silver' => ['10% cashback', 'Free shipping', 'Priority support'],
            'gold' => ['15% cashback', 'Free shipping', 'Priority support', 'Exclusive products'],
            'platinum' => ['20% cashback', 'Free shipping', 'Priority support', 'Exclusive products', 'Personal shopper']
        ];

        return $benefits[$tier] ?? $benefits['bronze'];
    }
}