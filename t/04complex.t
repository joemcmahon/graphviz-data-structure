#!/usr/bin/perl -w

BEGIN {
  unshift @INC,'../lib';
}

use Test::More tests=>2;
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

sub normalize {
   my $string = shift;
   $string =~ tr/\n/ /;
   $string =~ s/\s+/ /g;
   $string = "" if $string eq " ";
   $string;
}

__DATA__
(name => 'verify port assignments',
 code => 'my @a=(Nil=>[],Nada=>[],Zip=>[]); GraphViz::Data::Structure->new(\\@a,graph=>{label=>"verify port assignments"})->graph->as_canon',
 out  => qq(digraph test {
	graph [label="verify port assignments"];
	node [label="\\N"];
	{
		graph [rank=same];
		gvds_array0 [label="{<port1>Nil}|{<port2>.}|{<port3>Nada}|{<port4>.}|{<port5>Zip}|{<port6>.}", color=white, fontcolor=black, rank=0, shape=record, style=filled];
	}
	{
		graph [rank=same];
		gvds_array1 [label="[]", rank=1, shape=plaintext];
		gvds_array2 [label="[]", rank=1, shape=plaintext];
		gvds_array3 [label="[]", rank=1, shape=plaintext];
	}
	gvds_array0:port2 -> gvds_array1;
	gvds_array0:port4 -> gvds_array2;
	gvds_array0:port6 -> gvds_array3;
}

)
)
%%
(name => 'verify circular links',
 code => 'my @a; @a=(\\@a,\\@a,\\\\@a); GraphViz::Data::Structure->new(\\@a,graph=>{label=>"verify circular links"})->graph->as_canon',
 out  => qq(
)
)
