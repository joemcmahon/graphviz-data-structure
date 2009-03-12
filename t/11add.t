#!/usr/bin/perl -w

BEGIN {
  unshift @INC,'../lib';
}

use Test::More tests=>4;
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
(name => 'refs to scalars, new',
 code => '@a=(); foreach (qw(this is a test)){push @a,\\$_}; GraphViz::Data::Structure->new(\\@a,graph=>{label=>"refs to scalars, new"})->graph->as_canon',
 out  => qq(digraph test {
	graph [label="refs to scalars, new"];
	node [label="\\N"];
	{
		graph [rank=same];
		gvds_array0 [label="{<port1>.}|{<port2>.}|{<port3>.}|{<port4>.}", color=white, fontcolor=black, rank=0, shape=record, style=filled];
	}
	{
		graph [rank=same];
		gvds_atom0 [label=this, rank=1, shape=plaintext];
		gvds_atom1 [label=is, rank=1, shape=plaintext];
		gvds_atom2 [label=a, rank=1, shape=plaintext];
		gvds_atom3 [label=test, rank=1, shape=plaintext];
	}
	gvds_array0:port1 -> gvds_atom0;
	gvds_array0:port2 -> gvds_atom1;
	gvds_array0:port3 -> gvds_atom2;
	gvds_array0:port4 -> gvds_atom3;
}

)
)
%%
(name => 'refs to scalars, add',
 code => '@a=(); foreach (qw(this is a test)){push @a,\\$_}; $gvds=GraphViz::Data::Structure->new(); $gvds->add(\\@a,graph=>{label=>"refs to scalars, add"}); $gvds->graph->as_canon',
 out  => qq(digraph test {
	node [label="\\N"];
	{
		graph [rank=same];
		gvds_atom0 [label=undef, rank=0, shape=plaintext];
		gvds_array0 [label="{<port1>.}|{<port2>.}|{<port3>.}|{<port4>.}", rank=0, shape=record, color=white, fontcolor=black, style=filled];
	}
	{
		graph [rank=same];
		gvds_atom1 [label=this, rank=1, shape=plaintext];
		gvds_atom2 [label=is, rank=1, shape=plaintext];
		gvds_atom3 [label=a, rank=1, shape=plaintext];
		gvds_atom4 [label=test, rank=1, shape=plaintext];
	}
	gvds_array0:port1 -> gvds_atom1;
	gvds_array0:port2 -> gvds_atom2;
	gvds_array0:port3 -> gvds_atom3;
	gvds_array0:port4 -> gvds_atom4;
}

)
)
%%
(name => 'refs to scalars, two arrays, new+add',
 code => '@a=(); foreach (qw(this is a test)){push @a,\\$_}; @b=(); foreach (sort @a) {push @b,$_}; $gvds=GraphViz::Data::Structure->new(\\@a,graph=>{label=>"refs to scalars, two arrays, new+add"});$gvds->add(\\@b); $gvds->graph->as_canon',
 out  => qq(digraph test {
	graph [label="refs to scalars, two arrays, new+add"];
	node [label="\\N"];
	{
		graph [rank=same];
		gvds_array0 [label="{<port1>.}|{<port2>.}|{<port3>.}|{<port4>.}", color=white, fontcolor=black, rank=0, shape=record, style=filled];
		gvds_array1 [label="{<port1>.}|{<port2>.}|{<port3>.}|{<port4>.}", color=white, fontcolor=black, rank=0, shape=record, style=filled];
	}
	{
		graph [rank=same];
		gvds_atom0 [label=this, rank=1, shape=plaintext];
		gvds_atom1 [label=is, rank=1, shape=plaintext];
		gvds_atom2 [label=a, rank=1, shape=plaintext];
		gvds_atom3 [label=test, rank=1, shape=plaintext];
	}
	gvds_array0:port1 -> gvds_atom0;
	gvds_array0:port2 -> gvds_atom1;
	gvds_array0:port3 -> gvds_atom2;
	gvds_array0:port4 -> gvds_atom3;
	gvds_array1:port1 -> gvds_atom0;
	gvds_array1:port2 -> gvds_atom1;
	gvds_array1:port4 -> gvds_atom2;
	gvds_array1:port3 -> gvds_atom3;
}

)
)
%%
(name => 'refs to scalars, two arrays, add+add',
 code => '@a=(); foreach (qw(this is a test)){push @a,\\$_}; @b=(); foreach (sort @a) {push @b,$_}; $gvds=GraphViz::Data::Structure->new();$gvds->add(\\@a,graph=>{label=>"refs to scalars, two arrays, add+add"});$gvds->add(\\@b);$gvds->graph->as_canon',
 out  => qq(digraph test {
	node [label="\\N"];
	{
		graph [rank=same];
		gvds_atom0 [label=undef, rank=0, shape=plaintext];
		gvds_array0 [label="{<port1>.}|{<port2>.}|{<port3>.}|{<port4>.}", rank=0, shape=record, color=white, fontcolor=black, style=filled];
		gvds_array1 [label="{<port1>.}|{<port2>.}|{<port3>.}|{<port4>.}", rank=0, shape=record, color=white, fontcolor=black, style=filled];
	}
	{
		graph [rank=same];
		gvds_atom1 [label=this, rank=1, shape=plaintext];
		gvds_atom2 [label=is, rank=1, shape=plaintext];
		gvds_atom3 [label=a, rank=1, shape=plaintext];
		gvds_atom4 [label=test, rank=1, shape=plaintext];
	}
	gvds_array0:port1 -> gvds_atom1;
	gvds_array0:port2 -> gvds_atom2;
	gvds_array0:port3 -> gvds_atom3;
	gvds_array0:port4 -> gvds_atom4;
	gvds_array1:port2 -> gvds_atom1;
	gvds_array1:port1 -> gvds_atom2;
	gvds_array1:port4 -> gvds_atom3;
	gvds_array1:port3 -> gvds_atom4;
}

)
)
