<?php

namespace App\Http\Controllers;

use App\Models\UserResume;
use App\Service\Resume\AddProfile;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class ResumeController extends Controller
{
    public function show(): View
    {
        $userName = auth()->user()->name ?? 'Guest';

        $existingResume = UserResume::where('user_id', auth()->user()->id)->first();

        return view('resume', [
            'userName' => $userName,
            'existingResume' => $existingResume,
        ]);
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

        $added = (new AddProfile())->execute($validated);

        return redirect()->route('resume.result', $added);
    }

    public function showHash(Request $request): View
    {
        $resume = UserResume::where('user_id', auth()->user()->id)->firstOrFail();

        return view('resume.result', [
            'hash' => $resume->hash,
            'name' => $resume->name,
            'strengths' => $resume->strengths,
        ]);
    }
}
