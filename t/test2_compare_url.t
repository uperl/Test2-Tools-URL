use Test2::V0 -no_srand => 1;
use Test2::Tools::Compare::URL qw( url );
use Test2::Compare::URL;

subtest 'as string' => sub {

  is(
    'http://example.com',
    url {},
  );

};

subtest 'as URI' => sub {

  skip_all 'test requires URI' unless eval q{ require URI };

  is(
    URI->new('http://example.com'),
    url {},
  );

};

subtest 'as Mojo::URL' => sub {

  skip_all 'test requires URI' unless eval q{ require Mojo::URL };

  is(
    Mojo::URL->new('http://example.com'),
    url {},
  );

};

subtest 'non object references' => sub {

  my $e;

  is(
    $e = intercept { is( undef, url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given undef',
  );
  
  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

  is(
    $e = intercept { is( [], url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given []',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

  is(
    $e = intercept { is( {}, url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given {}',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

  is(
    $e = intercept { is( sub {}, url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given sub {}',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

  is(
    $e = intercept { is( \'', url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given \\\'\'',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

  is(
    $e = intercept { is( qr{}, url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given qr{}',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;
};

subtest 'bogus scheme' => sub {

  my $e;

  is(
    $e = intercept { is( "bogus://example.com", url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given bogus scheme',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

};

subtest 'relative url' => sub {

  my $e;

  is(
    $e = intercept { is( "./foo/bar", url {} ) },
    array {
      event Ok => sub {
        call pass => F();
      };
      etc;
    },
    'fails when given relative URL',
  );

  note $_->message for grep { $_->isa('Test2::Event::Diag') } @$e;

};

done_testing
