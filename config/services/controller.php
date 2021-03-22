<?php

declare(strict_types=1);

namespace Symfony\Component\DependencyInjection\Loader\Configurator;

use Acme\SyliusExamplePlugin\Controller\GreetingController;

return function (ContainerConfigurator $configurator) {
    $services = $configurator->services();

    $services->set(GreetingController::class)
        ->autowire()
        ->autoconfigure()
        ->public();
};
