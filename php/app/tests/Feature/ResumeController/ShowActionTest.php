<?php

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;

uses(RefreshDatabase::class);

test('show method displays the resume view with authenticated user name', function () {
    $user = User::factory()->create();
    $this->actingAs($user);

    $response = $this->get('/resume');

    $response->assertStatus(200);
    $response->assertViewIs('resume');
    $response->assertViewHas('userName', $user->name);
});

test('show method displays the resume view with "Guest" when user is not authenticated', function () {
    $response = $this->get('/resume');
    $response->assertRedirect('/login');
});
