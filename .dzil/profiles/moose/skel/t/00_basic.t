use strict;
use warnings;
use Test::More;

BEGIN { use_ok {{$name}} };

my $obj = {{$name}}->new(human => "3 Mb");

isa_ok $obj, '{{$name}}, 'Got a valid size obj.';



done_testing;
