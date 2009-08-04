package HasSigDie;

use strict;
use warnings;

$SIG{__DIE__} = sub { return 'whee!' };
sub doesn't_matter { 1 }

1;
