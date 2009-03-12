use ExtUtils::MakeMaker;
use 5.008;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME         => 'GraphViz::Data::Structure',
    VERSION_FROM => 'lib/GraphViz/Data/Structure.pm', # finds $VERSION
    AUTHOR       => 'Joe McMahon (mcmahon@ibiblio.org)',
    ABSTRACT     => 'Visualize Perl data structures',
    PREREQ_PM    => {GraphViz=>2.01,Devel::Peek=>0,Test::More=>0}
);
