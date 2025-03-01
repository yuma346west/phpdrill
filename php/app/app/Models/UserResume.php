<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UserResume extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'name',
        'strengths',
        'hash',
    ];

    /**
     * Get the user that owns the resume.
     * (One-to-One relationship)
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}