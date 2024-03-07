package Devel::REPL::Profile::CInet;

use Moose;
use namespace::autoclean;

with 'Devel::REPL::Profile';

sub plugins { qw(
    Colors
    Completion
    CompletionDriver::Globals
    CompletionDriver::INC
    CompletionDriver::LexEnv
    CompletionDriver::Keywords
    CompletionDriver::Methods
    FancyPrompt
    History
    Interrupt
    LexEnv
    DataDump
    Packages
    Commands
    MultiLine::PPI
    ReadLineHistory
    OutputCache
    Silence
    SmartTiming
) }

sub apply_profile {
    my ($self, $repl) = @_;
    $repl->load_plugin($_) for $self->plugins;
    $repl->fancy_prompt(sub {
        my $self = shift;
        sprintf 'CImake|%03d> ', $self->lines_read;
    });

    # Load packages
    $repl->eval(q[use Modern::Perl 2018;;]);
    $repl->eval(q[use CInet::Tools;;]);
    # Macaulay2 style recent results
    $repl->eval(q[sub oo  { $_REPL->output_cache->[-1] };;]);
    $repl->eval(q[sub ooo { $_REPL->output_cache->[-2] };;]);
}

":wq"
