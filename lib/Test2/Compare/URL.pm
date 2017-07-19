package Test2::Compare::URL;

use strict;
use warnings;
use 5.008001;
use overload ();
use URI;
use Scalar::Util qw( blessed );
use Carp ();
use base qw( Test2::Compare::Base );

# ABSTRACT: Representation of a URL during deep comparison.
# VERSION

=head1 DESCRIPTION

This class lets you specify a URL in a deep comparison.

=head1 SEE ALSO

L<Test2::Suite>, L<Test2::Tools::Compare::URL>

=cut

sub name { '<URL>' }

sub _uri
{
  my($self, $url) = @_;
  $self->{base}
    ? URI->new_abs("$url", $self->{base})
    : URI->new("$url");
}

sub verify
{
  my($self, %params) = @_;
  my($got, $exists) = @params{qw/ got exists /};
  
  return 0 unless $exists;
  return 0 unless $got;
  return 0 if ref($got) && !blessed($got);
  return 0 if ref($got) && !overload::Method($got, '""');
  
  my $url = eval { $self->_uri($got) };  
  return 0 if $@;
  return 0 if ! $url->has_recognized_scheme;
  
  return 1;
}

sub set_base
{
  my($self, $base) = @_;
  $self->{base} = $base;
}

sub add_component
{
  my($self, $name, $expect) = @_;
  push @{ $self->{component} }, [ $name, $expect ];
}

sub deltas
{
  my($self, %args) = @_;
  my($got, $convert, $seen) = @args{'got', 'convert', 'seen'};

  my $uri = $self->_uri($got);
  
  my @deltas;
  
  foreach my $comp (@{ $self->{component} })
  {
    my($name, $expect) = @$comp;
    
    my $method = $name;
    $method = 'host_port' if $method eq 'hostport';
    my $value = $uri->$method;
    my $check = $convert->($expect);

    if($method eq 'query' && !$check->isa('Test2::Compare::String'))
    {
      my @query = $uri->query_form;
      if($check->isa('Test2::Compare::Hash'))
      {
        my %query = @query;
        $value = \%query;
      }
      elsif($check->isa('Test2::Compare::Array'))
      {
        $value = \@query;
      }
    }


    push @deltas => $check->run(
      id      => [ HASH => $name ],
      convert => $convert,
      seen    => $seen,
      exists  => defined $value,
      got     => $value,
    );
  }
  
  @deltas;
}

1;
