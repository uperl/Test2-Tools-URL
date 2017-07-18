package Test2::Tools::Compare::URL;

use strict;
use warnings;
use 5.008001;
use Test2::Compare      ();
use Test2::Compare::URL ();
use base qw( Exporter );

our @EXPORT = qw( url );

# ABSTRACT: Compare a URL in your Test2 test
# VERSION

=head1 SYNOPSIS

 use Test2::V0;
 use Test2::Compare::URL;
 
 is(
   "http://example.com",
   url {
   },
   'url is as expected',
 );

=head1 DESCRIPTION

This set of L<Test2> tools helps writing tests against
URLs, represented as either strings, or as objects that
stringify to URLs (such as L<URI> or L<Mojo::URL>).

=head1 FUNCTIONS

=head2 url

 my $check = url {}

Checks that the given string or object is a valid URL.

=cut

sub url (&)
{
  Test2::Compare::build('Test2::Compare::URL', @_);
}

1;

=head1 SEE ALSO

L<Test2::Suite>

=cut
