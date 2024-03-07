package Devel::REPL::Plugin::Silence;

use Devel::REPL::Plugin;
use namespace::autoclean;

has '_silence' => (
    is => 'rw', lazy => 1,
    default => 0,
);

before 'eval' => sub {
    my ($self, $line) = @_;
    $self->_silence(!!($line =~ /;;$/));
};

around 'format_result' => sub {
    my $orig = shift;
    my $self = shift;
    return if $self->_silence;
    $self->$orig(@_);
};

":wq"
