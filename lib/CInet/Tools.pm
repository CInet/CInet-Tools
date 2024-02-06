=encoding utf8

=head1 NAME

CInet::Tools - Bundle for all CInet modules

=head1 SYNOPSIS

    # Imports CInet::*
    use CInet::Tools;

=head2 VERSION

This document describes CInet::Tools v0.1.

=cut

# ABSTRACT: Bundle for all CInet modules
package CInet::Tools;

our $VERSION = "v0.1";

use Modern::Perl 2018;
use Import::Into;

sub import {
    CInet::Base          -> import::into(1);
    CInet::ManySAT       -> import::into(1);
    CInet::Propositional -> import::into(1);
    CInet::Gaussoids     -> import::into(1);
    CInet::Polyhedral    -> import::into(1);
    CInet::Semimatroids  -> import::into(1);
    CInet::Adhesive      -> import::into(1);
}

=head1 AUTHOR

Tobias Boege <tobs@taboege.de>

=head1 COPYRIGHT AND LICENSE

This software is copyright (C) 2020 by Tobias Boege.

This is free software; you can redistribute it and/or
modify it under the terms of the Artistic License 2.0.

=cut

":wq"
