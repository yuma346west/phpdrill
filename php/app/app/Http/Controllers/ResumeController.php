<?php

namespace App\Http\Controllers;

use App\Models\UserResume;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class ResumeController extends Controller
{
    public function show(): View
    {
        $userName = auth()->user()->name ?? 'Guest';
        return view('resume', ['userName' => $userName]);
    }

    /**
     * Validates and processes the provided data to create a profile, then redirects to the result route.
     *
     * @param Request $request The HTTP request containing profile data inputs.
     * @return RedirectResponse A redirection to the route displaying the profile result.
     */
    public function addProfile(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:50',
            'strengths' => 'required|string|max:400',
        ]);

        $uniqueHash = hash('sha256', auth()->user()->email);

        UserResume::create([
            'user_id' => auth()->user()->id,
            'name' => $validated['name'],
            'strengths' => $validated['strengths'],
        ]);


        return redirect()->route('resume.result', [
            'hash' => $uniqueHash,
            'name' => $validated['name'],
            'strengths' => $validated['strengths'],
        ]);
    }

    public function showHash(Request $request): View
    {
        $validated = $request->validate([
            'hash' => 'required|string',
            'name' => 'required|string|max:50',
            'strengths' => 'required|string|max:400',
        ]);

        return view('resume.result', $validated);
    }
}
