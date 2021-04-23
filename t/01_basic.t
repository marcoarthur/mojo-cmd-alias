use strict;
use Test::More 0.98;

use_ok $_ for qw(
Mojo::Command::alias
);

## no critic
package FakeApp;
use Mojolicious::Lite;
use Mojo::Command::alias;

push @{app->commands->namespaces}, 'Mojo::Command';

package main;

# start application
my $app;
{
    local $ENV{MOJO_APP_LOADER} = 1;
    $app = Mojolicious::Commands->start_app('FakeApp');
    pass "application started" if $app;
}

my $buffer = '';
subtest 'aliases for mojo command' => sub {
    open my $handle, '>', \$buffer;
    local *STDOUT = $handle;
    local $ENV{HARNESS_ACTIVE} = 0;
    $app->start('alias');
    for my $cmd ( qw{ GET PUT POST DELETE PATCH } ) {
        like $buffer, qr/alias.*get -M $cmd/, "get -M $cmd aliased command";
    }
};


done_testing;
