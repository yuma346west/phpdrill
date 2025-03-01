<?php

it('calculates the correct sha256 hash', function () {
    $email = 'test@example.com';
    $calculatedHash = hash('sha256', $email);

    expect($calculatedHash)->toBe('973dfe463ec85785f5f95af5ba3906eedb2d931c24e69824a89ea65dba4e813b');
});
