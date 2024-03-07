package Devel::REPL::Plugin::SmartTiming;

use Modern::Perl 2018;
use Devel::REPL::Plugin;
use Time::HiRes 'time';
use Term::ANSIColor;
use namespace::autoclean;

has '_timing' => (
    is => 'rw', lazy => 1,
    default => 0.0,
);

around 'eval' => sub {
    my $orig = shift;
    my ($self, $line) = @_;

    my @ret;
    my $start = time;
    do {
        if (wantarray) {
            @ret = $self->$orig($line);
        }
        else {
            $ret[0] = $self->$orig($line);
        }
    };
    $self->_timing(time - $start);

    return @ret;
};

around 'format_result' => sub {
    my $orig = shift;
    my $self = shift;
    my $time_diff = $self->_timing;
    my $res = $self->$orig(@_) // '';
    unless ($time_diff < 0.01) {
        my $mins = int($time_diff / 60);
        my $secs = $time_diff - 60*$mins;
        $res .= ' ' if length($res);
        $res .= colored(sprintf("# time=%02d:%05.2f", $mins, $secs), 'bright_black');
    }
    $res
};

":wq"
