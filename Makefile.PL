use ExtUtils::MakeMaker;
use 5.008;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my $dot_version = `dot -V 2>&1`;

if (!$dot_version) {
  die "You must install the graphviz package (http://www.graphviz.org) before using this module.\n";
}
else {
  my ($v) = ($dot_version =~ /dot version (.*?) /);
  die "You must have at least version 2.2 of dot to use this module" if ($v+0 < 2.2);
}

WriteMakefile(
    NAME         => 'GraphViz::Data::Structure',
    VERSION_FROM => 'lib/GraphViz/Data/Structure.pm', # finds $VERSION
    AUTHOR       => 'Joe McMahon (mcmahon@ibiblio.org)',
    ABSTRACT     => 'Visualize Perl data structures',
    PREREQ_PM    => {GraphViz=>2.02,Devel::Peek=>0,Test::More=>0}
);
