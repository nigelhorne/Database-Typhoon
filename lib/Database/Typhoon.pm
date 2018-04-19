package Database::Typhoon;

# use 5.027009;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Database::Typhoon ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Database::Typhoon', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Database::Typhoon - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Database::Typhoon;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Database::Typhoon, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

L<https://github.com/jonahharris/osdb-typhoon>

=head1 AUTHOR

Nigel Horne, E<lt>njh@bandsman.co.ukE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2018 by Nigel Horne

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.27.9 or,
at your option, any later version of Perl 5 you may have available.


=cut
