#!/usr/bin/perl -w

BEGIN {
  unshift @INC,'../lib';
}

use Test::More tests=>1;
use GraphViz::Data::Structure;

while (my $current = get_current()) {
  %hash = eval $current;
  my $result = eval $hash{'code'};
  die $@ if $@;
  is (normalize($result), normalize($hash{'out'}), $hash{'name'});
}

sub get_current {
   my $code = "";
   while (<DATA>) {
   last if /%%/;
   $code .= $_;
   }
   $code;
}

sub normalize {  }

__DATA__
(name => 'verify circular links (dot cannot render)',
 code => 'my @a; @a=(\\@a,\\@a,\\\\@a); GraphViz::Data::Structure->new(\\@a,graph=>{label=>"verify circular links (dot cannot render)"})->graph->as_canon',
 out  => qq(
)
)
