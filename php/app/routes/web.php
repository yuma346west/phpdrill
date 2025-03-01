<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ResumeController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get('/resume', [ResumeController::class, 'show'])->name('resume');
    Route::get('/resume/result', [ResumeController::class, 'showHash'])->name('resume.result');
    Route::post('/resume', [ResumeController::class, 'addProfile'])->name('resume.addProfile');
});
Route::get('/health', function () {
    return response()->json(['status' => 'OK'], 200);
});

require __DIR__.'/auth.php';
