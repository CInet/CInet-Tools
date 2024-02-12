=encoding utf8

=head1 NAME

Reply::Plugin::Timing - Attach timing information to result line

=head1 SYNOPSIS

.replyrc:

    [Timing]

In Perl:

    Reply->new(plugins => [ 'Timing' ])->run

=cut

# ABSTRACT: Attach timing information to result line
package Reply::Plugin::Timing;

use utf8;
use strict;
use warnings;

use base 'Reply::Plugin';

use Time::HiRes qw(time);
use Memory::Usage;
use Number::Bytes::Human qw(format_bytes);

use constant TIMING_KEY => 'timing_data';

sub execute {
    my $self = shift;
    my $next = shift;
    #my $mu = Memory::Usage->new;
    #$mu->record('start execution');
    my $start = time;
    my @res = $next->(@_);
    my $end = time;
    #$mu->record('end execution');

    #my $rss_diff = $mu->state->[1][3] - $mu->state->[0][3];
    my $time_diff = $end - $start;
    my $mins = int($time_diff / 60);
    my $secs = $time_diff - 60*$mins;
    $self->{+TIMING_KEY} = sprintf "# time=%02d:%05.2f", $mins, $secs;
    #$self->{+TIMING_KEY} = sprintf "# time=%02d:%05.2f, Δrss=%s",
    #    $mins, $secs,
    #    format_bytes($rss_diff * 1024, bs => 1024, si => 1);
    @res
}

sub print_result {
    my $self = shift;
    my $next = shift;
    $next->(@_, (0+ @_ ? ' ' : '') . $self->{+TIMING_KEY});
}

=head1 AUTHOR

Tobias Boege <tobs@taboege.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (C) 2021 by Tobias Boege.

This is free software; you can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

=cut

":wq"
