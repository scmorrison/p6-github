NAME
====

GitHub

DESCRIPTION
===========

Simple Perl6 GitHub API OAuth client.

MODULES AND UTILITIES
=====================

GitHub
--------------

```perl6
    use GitHub;

    my $gh = GitHub.new(
        auth_login => 'myusername',
        auth_password => 'mypassword'
    );

    my $ghauth = $gho.create_authentication(data => {
      :scopes(['user', 'repo', 'gist']),
      :note<'test-github-oauth-client'>
    });

    say $ghauth<token>;
```

Installation
============

Install directly with "panda":

    # From the source directory
   
    panda install .

SEE ALSO
========

* https://github.com/fayland/perl6-WebService-GitHub
* https://github.com/fayland/perl-net-github
* https://github.com/plu/Pithub

AUTHORS
=======

  * Sam Morrison

COPYRIGHT AND LICENSE
=====================

Copyright 2015 Sam Morrison

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
