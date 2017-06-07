use strict;
use warnings;

use POSIX qw(_exit);
use Linux::Clone;
use autodie;

local $|=1;

my $flag = Linux::Clone::NEWIPC|Linux::Clone::NEWNET|Linux::Clone::NEWUTS|Linux::Clone::NEWNS|Linux::Clone::NEWPID;

pipe my $READ, my $WRITE;

print "run $$\n";

my $pid = Linux::Clone::clone \&container, 0, POSIX::SIGCHLD|$flag;
print "Start $pid\n";

setup();

my $kid = waitpid $pid, 0;
print "waitpid: $kid ($!)\n",

print "exit..\n";

sub container {
    local $|=1;
    print "wait...\n";
    _wait();

    print "Container ($$) start\n";

    system "mount -t proc none /proc"
        and die "mount proc: $!";

    system "hostname HSDC"
        and die "hostname: $!";

    exec "bash";

    system "mount -t bind image new_root" 
        and die "mount bind $!";
    
    mkdir "new_root/old_root";

    system "pivot_root new_root old_root"
        and die "pivot_root: $!";

    system "mount -t proc none /proc"
        and die "mount proc: $!";

    system "ls /";
    system "ps a";
    system "hostname";
    system "ip a";

    #_exit(0);
}

sub setup {
    print "Start setup\n";
    sleep 1;
    print "Stop setup\n";

    _done();
}

sub _done {
    print $WRITE "\n";
    close $WRITE;
    close $READ;
}

sub _wait {
    <$READ>;
    close $READ;
    close $WRITE;
}
