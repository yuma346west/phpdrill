<?php

use App\Models\User;
use Illuminate\Support\Facades\Route;
use function Pest\Laravel\post;

beforeEach(function () {
    $this->user = User::factory()->create(['email' => 'test@example.com']);
    $this->actingAs($this->user);
    Route::post('/resume/add-profile', [\App\Http\Controllers\ResumeController::class, 'addProfile'])->name('resume.addProfile');
});

test('it redirects to the correct route with valid input', function () {
    $response = post(route('resume.addProfile'), [
        'name' => 'John Doe',
        'strengths' => 'Leadership, Communication',
    ]);

    $uniqueHash = hash('sha256', $this->user->email);

    $response->assertRedirect(route('resume.result', [
        'hash' => $uniqueHash,
        'name' => 'John Doe',
        'strengths' => 'Leadership, Communication',
    ]));
});

test('it fails when name is missing', function () {
    $response = post(route('resume.addProfile'), [
        'strengths' => 'Leadership, Communication',
    ]);

    $response->assertSessionHasErrors(['name']);
});

test('it fails when strengths are missing', function () {
    $response = post(route('resume.addProfile'), [
        'name' => 'John Doe',
    ]);

    $response->assertSessionHasErrors(['strengths']);
});

test('it fails when name exceeds max length', function () {
    $response = post(route('resume.addProfile'), [
        'name' => str_repeat('a', 51),
        'strengths' => 'Leadership, Communication',
    ]);

    $response->assertSessionHasErrors(['name']);
});

test('it fails when strengths exceed max length', function () {
    $response = post(route('resume.addProfile'), [
        'name' => 'John Doe',
        'strengths' => str_repeat('a', 401),
    ]);

    $response->assertSessionHasErrors(['strengths']);
});
