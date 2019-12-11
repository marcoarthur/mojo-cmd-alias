# NAME

Mojo::Command::alias - Command alias to your appliacation.

# SYNOPSIS

    mojo generate app mojo-app
    cd mojo-app
    eval $(./script/mojo-app alias)
    app
    app routes
    routes
    get /some/route
    post /some/route -c "{ some: 'data' }"
    delete /some/route/id

# DESCRIPTION

Mojo::Command::alias create shell aliases for your mojo app.
The application name is set to "app" . You also get alias for get, post,
delete, put, patch (REST verbs). You can check all the aliases created by
running it.

# LICENSE

Copyright (C) Marco Arthur.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Marco Arthur <arthurpbs@gmail.com>
