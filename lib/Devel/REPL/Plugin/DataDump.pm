package Devel::REPL::Plugin::DataDump;

use Modern::Perl 2018;
use Devel::REPL::Plugin;
use Data::Dump;
use namespace::autoclean;

around 'format_result' => sub {
    my $orig = shift;
    my $self = shift;
    my $v = (@_ > 1) ? [@_] : $_[0];
    $self->$orig(Data::Dump::dumpf($v, sub {
        my ($ctx, $obj) = @_;
        if ($ctx->is_blessed) {
            my $meth = $obj->can('description');
            return { dump => $obj->$meth } if $meth;
            return { dump => "$obj" } if overload::Method($obj, '""');
            # It's better to give a less informative response than to
            # clutter the session.
            return { dump => overload::StrVal($obj) };
        }
        undef
    }));
};

":wq"
