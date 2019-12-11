package Mojo::Command::alias;

use 5.010;
use Mojo::Base 'Mojolicious::Command', -signatures;
use Mojo::File;
use FindBin qw($Bin $RealScript);
use String::ShellQuote;
use DDP;

has description => "generate bash aliases for application\n";
has usage => "Usage: app alias | eval \"\$(app alias)\"\n";

sub _cmd_alias( $self, $aliaser ) {
    # absolute path
    my $cmd = Mojo::File->new($FindBin::Bin)->child($FindBin::RealScript);

    my %cmds = (
        app    => "$cmd",
        routes => "$cmd routes",
        get    => "$cmd get -M GET",
        post   => "$cmd get -M POST",
        delete => "$cmd get -M DELETE",
        patch  => "$cmd get -M PATCH",
        put    => "$cmd get -M PUT",
    );

    return map {
        my $arg = shell_quote ( "$^X $cmds{$_}" );
        "$aliaser $_=$arg" 
    } keys %cmds;
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
    app
    app routes
    routes
    get /some/route
    post /some/route -c "{ some: 'data' }"
    delete /some/route/id

=head1 DESCRIPTION

Mojo::Command::alias create shell aliases for your mojo app.
The application name is set to "app" . You also get alias for get, post,
delete, put, patch (REST verbs). You can check all the aliases created by
running it.

=head1 LICENSE

Copyright (C) Marco Arthur.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Marco Arthur E<lt>arthurpbs@gmail.comE<gt>

=cut

