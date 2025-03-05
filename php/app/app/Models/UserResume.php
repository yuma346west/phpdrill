<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

/**
 * 
 *
 * @property int $id
 * @property int $user_id
 * @property string $name
 * @property string $strengths
 * @property string $hash
 * @property \Illuminate\Support\Carbon|null $created_at
 * @property \Illuminate\Support\Carbon|null $updated_at
 * @property-read \App\Models\User $user
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume newModelQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume newQuery()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume query()
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereCreatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereHash($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereId($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereName($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereStrengths($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereUpdatedAt($value)
 * @method static \Illuminate\Database\Eloquent\Builder<static>|UserResume whereUserId($value)
 * @mixin \Eloquent
 */
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