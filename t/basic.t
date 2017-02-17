use v6;
use Test;
use DB::RSCS;

our $addr;
our $rscs-program;
our $proc;

BEGIN {
    say 'pre-test tasks';
    $addr = 'http://localhost:9999';
    $rscs-program = %*ENV{'GOPATH'} ~ '/bin/rscs';
    die "cannot execute $rscs-program" unless $rscs-program.IO.x;

    $proc = Proc::Async.new('/home/brad/gopath/bin/rscs', '--memory','--port=9999');
    $proc.stdout.tap(-> $v { print "Stdout: $v" }, quit => { say 'caught exception ' ~ .^name });
    $proc.stderr.tap(-> $v { print "Stderr: $v" });
    my $promise = $proc.start;
    sleep 1;
}

END {
    say 'post-test tasks';
    $proc.kill("SIGINT");
}

subtest {
    lives-ok {
        my $rscs = DB::RSCS.new(addr=>$addr);
    }, 'basic';
    dies-ok {
        my $rscs = DB::RSCS.new('junk');
    }, 'bad addr'
}, 'construct';

subtest {
    lives-ok {
        my $rscs = DB::RSCS.new(addr=>$addr);
        my %status = $rscs.status;
        is (%status<Alive>:exists), True, 'Alive';
        is (%status<DBFile>:exists), True, 'DBFile';
        is (%status<Uptime>:exists), True, 'Uptime';
    }, 'status';
}, 'status';
