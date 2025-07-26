<?php

use PHPUnit\Framework\Attributes\CoversNothing;

it('uses the correct PHPUnit attribute for covers nothing', function () {
    $attributes = (new ReflectionMethod($this, $this->name()))->getAttributes();

    expect($attributes[2]->getName())->toBe(CoversNothing::class);
    expect($attributes[2]->getArguments())->toHaveCount(0);
})->coversNothing();
