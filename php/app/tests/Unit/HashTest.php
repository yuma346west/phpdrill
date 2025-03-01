<?php

use PHPUnit\Framework\TestCase;

class HashTest extends TestCase
{
    public function test_sha256_hash_is_correct()
    {
        $email = 'test@example.com';
        $calculatedHash = hash('sha256', $email);

        $this->assertEquals('973dfe463ec85785f5f95af5ba3906eedb2d931c24e69824a89ea65dba4e813b', $calculatedHash);
    }
}
