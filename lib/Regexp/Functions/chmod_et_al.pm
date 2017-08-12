package Regexp::Functions::chmod_et_al;
use strict;
use 5.6.0;

our $VERSION     = '0.01';
our @ISA         = qw(Exporter);
our @EXPORT_OK = qw(
    $qr_chmod_et_al
);
use Carp;

my $qrstring = qr/[^,]+/;
my $qrcomma = qr/\s*,\s*/;
my $qrarrayref = qr/\[[^]]+\]/;
my $qrfalse = qr/(?:0|''|"")/;
my $qrfatarrow = qr/\s+=>\s+/;
my $funcs = qr/mkdir/;
my $qropenparen = qr/\s*\(\s*/;
my $qrclosparen = qr/\s*\)\s*/;
my $qrmf = qr/[0-7]/;
my $qrmodes = qr/\b(?:20${qrmf}${qrmf}|02${qrmf}${qrmf}|00${qrmf}${qrmf}|0${qrmf}${qrmf}|2${qrmf}${qrmf}|00|0)\b/;
my $qrspaceoropenparen = qr/(?:\s+|$qropenparen)/;
my $qropenbrack = qr/\s*\[\s*/;
my $qrclosbrack = qr/\s*\]\s*/;
my $qropencurly = qr/\s*\{\s*/;
my $qrcloscurly = qr/\s*\}\s*/;

#  my $cnt = chmod 0755, "foo", "bar";
#  mkdir FILENAME,MASK

my $qrmkdir = qr/
    mkdir
    ${qrspaceoropenparen}
    [^,]+
    ${qrcomma}
    ${qrmodes}
    (?:$qrclosparen)?
/x;

my $qrchmod = qr/
    chmod
    ${qrspaceoropenparen}
    ${qrmodes}
    ${qrcomma}
    [^,]+
    (?:,[^,]+)*
    (?:$qrclosparen)?
/x;

my $qrmkpath = qr/
    mkpath
    ${qrspaceoropenparen}
    [^,]+
    ${qrcomma}
    [01]
    ${qrcomma}
    ${qrmodes}
    (?:$qrclosparen)?
/x;

my $qrmkpath2 = qr/
    mkpath
    ${qrspaceoropenparen}
    ${qropenbrack}
    [^,]+
    (?:,[^,]+)*
    ${qrclosbrack}
    ${qrcomma}
    [01]
    ${qrcomma}
    ${qrmodes}
    (?:$qrclosparen)?
/x;

=pod

    make_path('foo/bar/baz', '/zug/zwang', { verbose => 1, mode => 0711 });

    q|make_path($somedir, { verbose => 1, mode => 0000 })|,

=cut

my $qrmakepath = qr/
    make_path
    ${qrspaceoropenparen}
    [^,]+
    (?:,[^,]+)*
    ${qrcomma}
    ${qropencurly}
    (?:[^,]+${qrcomma})*
    mode${qrfatarrow}${qrmodes}
    ${qrcloscurly}
    (?:$qrclosparen)?
/x;

########################################

our $qr_chmod_et_al;

$qr_chmod_et_al = qr/
    ( # This should be the only capture!
    ${qrmkdir} # mkdir
    |
    ${qrchmod} # chmod
    |
    ${qrmkpath} # mkpath interface 1
    |
    ${qrmkpath2} # mkpath interface 2
    |
    ${qrmakepath} # make_path
    )
/x;

=head1 NAME

Regexp::Functions::chmod_et_al - Patterns for matching Perl functions chmod(), mkdir(), File::Path::mkpath(), File::Path::makepath()

=head1 SYNOPSIS

  use Regexp::Functions::chmod_et_al;
  blah blah blah


=head1 DESCRIPTION

Stub documentation for this module was created by ExtUtils::ModuleMaker.
It looks like the author of the extension was negligent enough
to leave the stub unedited.

Blah blah blah.


=head1 USAGE



=head1 BUGS



=head1 SUPPORT



=head1 AUTHOR

    James E Keenan
    CPAN ID: JKEENAN
    jkeenan@cpan.org
    http://thenceforward.net/perl/modules

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.


=head1 SEE ALSO

perl(1).

=cut

1;

