use Test2::V0 -no_srand => 1;
use Test2::Tools::Compare::URL;

imported_ok $_ for qw(
  url
  url_base
  url_component
);

done_testing
