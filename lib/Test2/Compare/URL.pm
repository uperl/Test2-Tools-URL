package Test2::Compare::URL;

use strict;
use warnings;
use 5.008001;
use overload ();
use URI;
use Scalar::Util qw( blessed );
use base qw( Test2::Compare::Base );

# ABSTRACT: Representation of a URL during deep comparison.
# VERSION

=head1 DESCRIPTION

This class lets you specify a URL in a deep comparison.

=head1 SEE ALSO

L<Test2::Suite>, L<Test2::Tools::Compare::URL>

=cut

sub name { '<URL>' }

sub verify
{
  my($self, %params) = @_;
  my($got, $exists) = @params{qw/ got exists /};
  
  return 0 unless $exists;
  return 0 unless $got;
  return 0 if ref($got) && !blessed($got);
  return 0 if ref($got) && !overload::Method($got, '""');
  
  my $url = eval { URI->new("$got") };  
  return 0 if $@;
  return 0 if ! $url->has_recognized_scheme;
  
  return 1;
}

1;
