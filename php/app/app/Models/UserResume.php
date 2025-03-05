<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Carbon;

/**
 *
 *
 * @property int $id
 * @property int $user_id
 * @property string $name
 * @property string $strengths
 * @property string $hash
 * @property Carbon|null $created_at
 * @property Carbon|null $updated_at
 * @property-read User $user
 * @method static Builder<static>|UserResume newModelQuery()
 * @method static Builder<static>|UserResume newQuery()
 * @method static Builder<static>|UserResume query()
 * @method static Builder<static>|UserResume whereCreatedAt($value)
 * @method static Builder<static>|UserResume whereHash($value)
 * @method static Builder<static>|UserResume whereId($value)
 * @method static Builder<static>|UserResume whereName($value)
 * @method static Builder<static>|UserResume whereStrengths($value)
 * @method static Builder<static>|UserResume whereUpdatedAt($value)
 * @method static Builder<static>|UserResume whereUserId($value)
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
