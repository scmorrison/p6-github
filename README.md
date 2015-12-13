NAME
====

GitHub::OAuth

DESCRIPTION
===========

Simple Perl6 GitHub API OAuth client.

MODULES AND UTILITIES
=====================

GitHub::OAuth
--------------

```perl6
    use GitHub::OAuth;

    my $gh = GitHub::OAuth.new(
        auth_login => 'myusername',
        auth_password => 'mypassword'
    );

    my $ghauth = $gho.create_authentication(data => {
      :scopes(['user', 'repo', 'gist']),
      :note<'test-github-oauth-client'>
    });

    say $ghauth<token>;
```

AUTHORS
=======

  * Sam Morrison

COPYRIGHT AND LICENSE
=====================

Copyright 2015 Sam Morrison

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
