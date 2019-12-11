package Mojo::Command::alias;

use 5.010;
use Mojo::Base 'Mojolicious::Command', -signatures;
use Cwd;
use File::Spec;
use FindBin qw($Bin $RealScript);
use DDP;

has description => "generate bash aliases for application\n";
has usage => "Usage: app alias | eval \$(app alias)\n";

sub _cmd_alias( $self, $aliaser ) {
    my $cwd = getcwd;
    my $cmd = $FindBin::RealScript;
    my $abs = $FindBin::Bin;
    my $rel_path = File::Spec->abs2rel($abs, $cwd);
    $cmd = File::Spec->catfile($rel_path, $cmd);

    my %cmds = (
        routes => "$cmd routes",
        get    => "$cmd get -M GET",
        post   => "$cmd get -M POST",
    );

    return map { "$aliaser $_='$cmds{$_}'" } keys %cmds;
}

sub run ( $self, @args ) {
    my $aliaser = 'alias';

    say join "\n", $self->_cmd_alias($aliaser); 
}

1;
__END__

=encoding utf-8

=head1 NAME

Mojo::Command::alias - Command alias to your appliacation.

=head1 SYNOPSIS

    mojo generate app mojo-app
    cd mojo-app
    eval $(./script/mojo-app alias)
    app routes
    get /some/route
    post /some/route -c "{ some: 'data' }"
    delete /some/route/id

=head1 DESCRIPTION

Mojo::Command::alias create shell aliases for your mojo app

=head1 LICENSE

Copyright (C) Marco Arthur.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Marco Arthur E<lt>arthurpbs@gmail.comE<gt>

=cut

