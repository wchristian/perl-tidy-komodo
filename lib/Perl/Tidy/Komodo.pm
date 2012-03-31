use strictures;

package Perl::Tidy::Komodo;

# VERSION

# ABSTRACT: tidy perl files in Komodo with a project rc

# COPYRIGHT

use Perl::Tidy;
use File::chdir;

=head1 METHODS

=head2 run

Tries to find a directory that looks like a project directory, upwards
from CWD and stores its path in $ENV{PERLTIDY}. Then Perl::Tidy itself is
run.

=cut

sub run {
    _try_set_perltidy_env();
    Perl::Tidy::perltidy();
}

sub _try_set_perltidy_env {
    return if exists $ENV{PERLTIDY};
    my @cwd_store = @CWD;
    while ( $CWD[0] ) {
        if ( -d 'lib' and -f '.perltidyrc' ) {
            $ENV{PERLTIDY} = $CWD;
            last;
        }
        pop @CWD;
    }
    @CWD = @cwd_store;
    return;
}

1;
