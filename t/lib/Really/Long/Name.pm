package Really::Long::Name;

# fake version number, used to test
our $VERSION = '1.25';

sub new { bless {} => shift }

sub thing { return $_[1] + 2 }

1;
