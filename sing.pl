#!/usr/bin/perl -w

# USAGE:
#
# /sing <text>
#  - same as /say, but surrounds text with notes ♪♫ to make it look like you are singing
#
use strict;
use vars qw($VERSION %IRSSI);

$VERSION = "0.1";
%IRSSI = (
    authors     => 'Tony Miller',
    contact     => 'mcfiredrill@gmail.com',
    name        => 'sing',
    description => 'Allows you to sing.',
    license     => 'WTFPL',
);

use Irssi;
use Irssi::Irc;

my @notes = ('♫','♪');

# str sing_string($string)
# interpolates notes in your string to let everyone know you are singing and not talking
sub sing_string {
  my ($string) = @_;
  my $newstr = "";
  $newstr .= $notes[int(rand(scalar(@notes)))];
  $newstr .= $string;
  $newstr .= $notes[int(rand(scalar(@notes)))];

  return $newstr;
}

# handles /sing
sub sing {
  my ($text, $server, $dest) = @_;

  if (!$server || !$server->{connected}) {
          Irssi::print("Not connected to server");
          return;
  }

  return unless $dest;

  if ($dest->{type} eq "CHANNEL" || $dest->{type} eq "QUERY") {
          $dest->command("/msg " . $dest->{name} . " " . sing_string($text));
  }
}

Irssi::command_bind("sing", "sing");
