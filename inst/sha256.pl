#!/usr/bin/perl

use Digest::SHA qw(sha256_base64);

$sig = sha256_base64($ARGV[0], $ARGV[1]);

print $sig, "\n";
