{
    package OOP::Perlish::Class::Accessor::UnitTests::ScalarRef;
    use OOP::Perlish::Class::Accessor::UnitTests::Scalar;
    use base qw(OOP::Perlish::Class::Accessor::UnitTests::Scalar);
    use OOP::Perlish::Class::Accessor;
    use Test::More;
    use Data::Dumper;

    sub setup : Test(setup)
    {
        my ($self) = @_;
        $self->{accessor} = OOP::Perlish::Class::Accessor->new( type => 'SCALARREF', name => 'test', self => bless({}, __PACKAGE__) );
    }

    sub get_value
    {
        my ($self) = @_;
        return ${ $self->{accessor}->value() } if(ref($self->{accessor}->value()) eq 'SCALAR');
    }

    sub cannot_mutate_reference : Test(1)
    {
        my ($self) = @_;

        $self->{accessor}->value('quux');
        ${ $self->{accessor}->value() } = 'bar';
        is( ${ $self->{accessor}->value() }, 'quux', 'cannot mutate instance reference' ) || diag(Dumper($self->{accessor}->value()));
    }
}
1;
=head1 NAME

=head1 VERSION

=head1 SYNOPSIS

=head1 METHODS

=head1 AUTHOR

Jamie Beverly, C<< <jbeverly at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-foo-bar at rt.cpan.org>,
or through
the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=OOP-Perlish-Class>.  I will be
notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc OOP::Perlish::Class


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=OOP-Perlish-Class>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/OOP-Perlish-Class>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/OOP-Perlish-Class>

=item * Search CPAN

L<http://search.cpan.org/dist/OOP-Perlish-Class/>

=back


=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2009 Jamie Beverly

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
