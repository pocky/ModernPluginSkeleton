<?php

use PhpCsFixer\Fixer\ArrayNotation\ArraySyntaxFixer;
use PhpCsFixer\Fixer\ClassNotation\VisibilityRequiredFixer;
use PhpCsFixer\Fixer\Phpdoc\PhpdocAlignFixer;
use Symplify\EasyCodingStandard\Config\ECSConfig;
use Symplify\EasyCodingStandard\ValueObject\Set\SetList;

return static function (ECSConfig $ecsConfig): void {
    $ecsConfig->import('vendor/sylius-labs/coding-standard/ecs.php');
    $ecsConfig->parallel();

    $ecsConfig->paths([
        __DIR__ . '/src',
        __DIR__ . '/tests/Behat',
        __DIR__ . '/ecs.php',
    ]);

    $ecsConfig->skip([
        __DIR__ . '/tests/Application',
        PhpdocAlignFixer::class,
        VisibilityRequiredFixer::class => ['*Spec.php'],
    ]);

    $ecsConfig->ruleWithConfiguration(ArraySyntaxFixer::class, [
        'syntax' => 'short',
    ]);

    // run and fix, one by one
    $ecsConfig->import(SetList::SYMFONY);
    $ecsConfig->import(SetList::SYMFONY_RISKY);
    $ecsConfig->import(SetList::PSR_12);
    $ecsConfig->import(SetList::PHP_CS_FIXER_RISKY);
};
