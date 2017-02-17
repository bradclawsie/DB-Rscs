use v6;
use HTTP::UserAgent;
use JSON::Tiny;

unit module DB::RSCS:auth<bradclawsie>:ver<0.0.1>;

constant DEFAULT_ADDR is export  = <http://localhost:8081>;
constant STATUS_PATH is export = '/v1/status';

class DB::RSCS is export {
    has HTTP::UserAgent $!http-client;
    has Str $.addr;
    
    submethod BUILD(Str:D :$addr = DEFAULT_ADDR) {
        $!http-client = HTTP::UserAgent.new();
        $!addr = $addr;
        X::AdHoc.new(:payload<'cannot connect'>).throw unless self.alive.so;
    }

    # Test for live-ness.
    method alive(--> Bool:D) {
        my $resp = $!http-client.get($!addr ~ STATUS_PATH);
        return $resp ~~ HTTP::Response && $resp.is-success;
    }

    # Get the status result.
    method status(--> Hash:D) {
        my $resp = $!http-client.get($!addr ~ STATUS_PATH);
        unless $resp ~~ HTTP::Response && $resp.is-success {
            X::AdHoc.new(:payload<STATUS_PATH>).throw;
        }
        return from-json($resp.decoded-content);
    }
}
