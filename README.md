# Test2::Tools::Compare::URL [![Build Status](https://secure.travis-ci.org/plicease/Test2-Tools-Compare-URL.png)](http://travis-ci.org/plicease/Test2-Tools-Compare-URL)

Compare a URL in your Test2 test

# SYNOPSIS

    use Test2::V0;
    use Test2::Compare::URL;
    
    is(
      "http://example.com",
      url {
      },
      'url is as expected',
    );

# DESCRIPTION

This set of [Test2](https://metacpan.org/pod/Test2) tools helps writing tests against
URLs, represented as either strings, or as objects that
stringify to URLs (such as [URI](https://metacpan.org/pod/URI) or [Mojo::URL](https://metacpan.org/pod/Mojo::URL)).

# FUNCTIONS

## url

    my $check = url {}

Checks that the given string or object is a valid URL.

# SEE ALSO

[Test2::Suite](https://metacpan.org/pod/Test2::Suite)

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
