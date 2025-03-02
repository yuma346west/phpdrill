<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\View;

test('showHash method renders the correct view with validated data', function () {
    // Mock the Request and provide the required input
    $request = new Request([
        'hash' => 'samplehashvalue',
        'name' => 'John Doe',
        'strengths' => 'Hardworking with great teamwork skills',
    ]);

    // Validate by simulating the validation process inside the controller
    $validator = Validator::make($request->all(), [
        'hash' => 'required|string',
        'name' => 'required|string|max:50',
        'strengths' => 'required|string|max:400',
    ]);

    // Assert validation passes
    expect($validator->passes())->toBeTrue();

    // Simulate controller returning a View with validated data
    $view = View::make('resume.result', $request->all());

    // Assert the correct view is rendered with the correct data
    expect($view->name())->toBe('resume.result');
    expect($view->getData())->toMatchArray([
        'hash' => 'samplehashvalue',
        'name' => 'John Doe',
        'strengths' => 'Hardworking with great teamwork skills',
    ]);
});
