#!/usr/bin/perl
use warnings;
use strict;
{
    package OOP::Perlish::Class::UnitTests::Base;
    use warnings;
    use strict;
    use Test::Class;
    use Test::More;
    use base qw(Test::Class);
}

{
	package Foo;
    use warnings;
    use strict;
	use OOP::Perlish::Class; 
	use base qw(OOP::Perlish::Class);

	BEGIN {
		__PACKAGE__->_accessors(
			foo => {
                type => 'SCALAR',
				validator => qr/.*foo.*/,
			},
		);
	};
}

{
	package Bar;
    use warnings;
    use strict;
	use OOP::Perlish::Class; 
	use base qw(OOP::Perlish::Class);

	BEGIN {
		__PACKAGE__->_accessors(
			foo => {
                type => 'SCALAR',
				validator => qr/.*ralph.*/i,
			},
		);
	};
}
{
    package Bar::Bar;
    use warnings;
    use strict;
    use base 'Bar';

    BEGIN {
        __PACKAGE__->_accessors(
            bar => {
                type => 'HASHREF',
                validator => qr/.*bar.*/,
            },
        );
    };
}
{
    package Baz;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);

    BEGIN {
        __PACKAGE__->_accessors(
            baz => {
                type => 'SCALAR',
                validator => qr/.*baz.*/,
            },
        );
    };
}

{
    package Baz::Foo::Bar;
    use warnings;
    use strict;
    use base qw( Foo Baz );

    BEGIN {
        __PACKAGE__->_accessors(
            bar => {
                type => 'SCALAR',
                validator => sub {
                    my $self = shift;
                    my $val = shift; 
                    
                    my $bazval = $val;
                    $bazval =~ s/bar/baz/ && do { 
                        $self->baz($bazval); 
                        return $val; 
                    }; 
                    return 
                },
                required => 1,
            },
        )
    };
}

{
    package Baz::Foo::Bar::Overload;
    use warnings;
    use strict;
    use base qw(Baz::Foo::Bar);

    BEGIN {
        __PACKAGE__->_accessors(
            bar => {
                type => 'SCALAR',
                validator => qr/.*overloaded.*/,
            },
        );
    };
}

{
    package Fred;
    use warnings;
    use strict;
    use IO::File;
    use base qw(OOP::Perlish::Class File::Find);

    BEGIN { 
        __PACKAGE__->_accessors(
            bar => {
                type => 'SCALAR',
                validator => qr/.*set.*/,
            },
        );
    };
}

{
    package TestRequired;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);

    BEGIN { 
        __PACKAGE__->_accessors(
            fud => {
                required => 1,
                type => 'SCALAR',
            },
        );
    };
}

{
    package TestAccessorOverloadingWithMethod;
    use warnings;
    use strict;

    use base qw(TestRequired);

    sub fud
    {
        my ($self) = @_;
        return 'method, not accessor';
    }
}



{
    package TestValidDefaults;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);
    use IO::File;

    BEGIN {
        __PACKAGE__->_accessors(
            'scalar' => {
                type => 'SCALAR',
                validator => qr/test/,
                default => 'test',
            },
            'array' => {
                type => 'ARRAY',
                validator => qr/test/,
                default => [ 'test' ],
            },
            'hash' => {
                type => 'HASH',
                validator => qr/test/,
                default => { key => 'test' },
            },
            'code' => {
                type => 'CODE',
                default => sub { return('test') },
            },
            'object' => {
                type => 'OBJECT',
                object_can => [ 'open' ], 
                default => IO::File->new(),
            },
        );
    };
}
 
{
    package TestInvalidDefaultScalar;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);
    use IO::File;

    BEGIN {
        __PACKAGE__->_accessors(
            'scalar' => {
                type => 'SCALAR',
                validator => qr/test/,
                default => 'invalid',
            },
        );
    }
}
{
    package TestInvalidDefaultArray;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);
    use IO::File;

    BEGIN {
        __PACKAGE__->_accessors(
            'array' => {
                type => 'ARRAY',
                validator => qr/test/,
                default => [ 'invalid' ],
            },
        );
    };
}
{
    package TestInvalidDefaultHash;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);
    use IO::File;

    BEGIN {
        __PACKAGE__->_accessors(
            'hash' => {
                type => 'HASH',
                validator => qr/test/,
                default => { asdf => 'invalid' },
            },
        );
    };
}
{
    package TestInvalidDefaultCode;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);
    use IO::File;

    BEGIN {
        __PACKAGE__->_accessors(
            'code' => {
                type => 'CODE',
                default => 'invalid',
            },
        );
    };
}
{
    package TestInvalidDefaultObject;
    use warnings;
    use strict;
    use base qw(OOP::Perlish::Class);
    use IO::File;

    BEGIN {
        __PACKAGE__->_accessors(
            'object' => {
                type => 'OBJECT',
                object_can => [ 'invalid_method_name' ], 
                default => IO::File->new(),
            },
        );
    };
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
