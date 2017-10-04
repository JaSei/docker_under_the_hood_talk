use strict;
use warnings;

use feature qw(say signatures);
no warnings qw(experimental::signatures);
use Path::Tiny;

require 'syscall.ph';
require 'linux/sched.ph';

my $pid = 28778;

#setns(CLONE_NEWNET(), 'net', 'ip a');
#say "\n----\n";
setns(CLONE_NEWUTS(), 'uts', 'hostname');
#say "\n----\n";
#setns(CLONE_NEWPID(), 'pid', 'ps a');
#say "\n----\n";
#setns(CLONE_NEWNS(), 'mnt', 'ls -al /');

sub setns($namespace_flag, $namespace_file, $command) {
    say "#Before setns ($namespace_file):\n";

    system $command;

    my $fh = path("/proc/$pid/ns/$namespace_file")->filehandle();

    if (syscall(SYS_setns(), fileno($fh), $namespace_flag) == -1) {
        die "setns ($namespace_flag - $namespace_file): $!";
    }

    say "\n#After setns ($namespace_file):\n";

    system $command;
}
