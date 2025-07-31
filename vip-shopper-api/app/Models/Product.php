<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'name',
        'description', 
        'price',
        'category',
        'image_url',
        'is_vip_exclusive'
    ];

    protected $casts = [
        'price' => 'decimal:2',
        'is_vip_exclusive' => 'boolean'
    ];

    // VIP Products scope
    public function scopeVipOnly($query)
    {
        return $query->where('is_vip_exclusive', true);
    }

    // Regular products scope  
    public function scopeRegular($query)
    {
        return $query->where('is_vip_exclusive', false);
    }
}