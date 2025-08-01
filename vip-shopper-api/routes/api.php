<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\AIController;

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