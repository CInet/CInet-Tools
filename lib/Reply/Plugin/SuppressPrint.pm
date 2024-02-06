=encoding utf8

=head1 NAME

Reply::Plugin::SuppressPrint - Use ";;" at the end of a line to suppress printing

=head1 SYNOPSIS

.replyrc:

    [SuppressPrint]

In Perl:

    Reply->new(plugins => [ 'SuppressPrint' ])->run

=cut

# ABSTRACT: Use ";;" at the end of a line to suppress printing
package Reply::Plugin::SuppressPrint;

use strict;
use warnings;

use base 'Reply::Plugin';

use constant LINE_KEY => 'suppressprint_line';

sub read_line {
    my $self = shift;
    my $next = shift;
    $self->{+LINE_KEY} = $next->(@_)
}

sub print_result {
    my $self = shift;
    my $next = shift;
    $next->(@_) unless ($self->{+LINE_KEY} // '') =~ /;; \s* $/x
}

=head1 AUTHOR

Tobias Boege <tobs@taboege.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (C) 2021 by Tobias Boege.

This is free software; you can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

=cut

":wq"
