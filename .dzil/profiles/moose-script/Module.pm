package {{$name}};
use feature 'say';
use Moose;
use namespace::autoclean;
use MooseX::Types::Common::String qw(NonEmptyStr);
use Carp;

with 'MooseX::Runnable', 'MooseX::Getopt', 'MooseX::LogDispatch::Levels';

# ABSTRACT: a really awesome library

=head1 SYNOPSIS



=cut

has verbose => (
    traits => [ 'Getopt' ],
    isa => 'Bool',
    is  => 'ro',
    cmd_aliases => 'v',
    documentation => 'Be verbose.'
   );

has '+logger' => (
    traits => [ 'NoGetopt' ],
   );

has '+use_logger_singleton' => (
    traits => [ 'NoGetopt' ],
   );

MooseX::Getopt::OptionTypeMap->add_option_type_to_map(
    MooseX::Types::Common::String::NonEmptyStr     => '=s',
   );

sub _build_log_dispatch_conf {
    my $self = shift;

    if ($self->verbose) {
        return {
            class     => 'Log::Dispatch::Screen',
            min_level => 'debug',
            stderr    => 1,
            format    => '[%p] %m at %F line %L%n',
        };
    } else {
        return {
            min_level => 'emergency',
            class     => 'Log::Dispatch::Null',
        };
    }
}

sub run {
    my $self = shift;

    return 0;
}

=head1 SEE ALSO

=for :list
* L<exec>
* L<Moose>
* L<MooseX::Runnable>
* L<MooseX::Getopt>
* L<MooseX::LogDispatch::Levels>
* L<Carp>

=cut

__PACKAGE__->meta->make_immutable;
