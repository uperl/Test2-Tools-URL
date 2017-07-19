package Test2::Tools::Compare::URL;

use strict;
use warnings;
use 5.008001;
use Carp                   ();
use Test2::Compare         ();
use Test2::Compare::URL    ();
use Test2::Compare::Hash   ();
use Test2::Compare::String ();
use base qw( Exporter );

our @EXPORT = qw( url url_component );

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

=head2 url_component

 url {
   url_component $component, $check;
 }

=over 4

=item scheme

=item authority

=item userinfo

=item hostport

=item host

=item port

=item path

=item query

=item fragment

=back

=cut

sub url_component ($$)
{
  my($name, $expect) = @_;
  
  Carp::croak("$name is not a valid URL component")
    unless $name =~ /^(?:scheme|authority|userinfo|hostport|host|port|path|query|fragment)$/;
  
  my $build = Test2::Compare::get_build()or Carp::croak("No current build!");

  $build->add_component($name, $expect);
}  

1;

=head1 SEE ALSO

L<Test2::Suite>

=cut
