#!/usr/bin/perl -w

use strict;
use IPC::Run qw(run);
$| = 1;

print "Attempting to make all tests...\n";

my($in, $out, $err);

foreach my $file (sort <*.data.in>) {
  print "  Running $file...";
  run ["/usr/bin/perl ./build_test @ARGV ./$file"], \$in, \$out, \$err; 
  print "done\n";
}

print "All tests rebuilt.\n";
