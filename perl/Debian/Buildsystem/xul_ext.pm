# A debhelper build system class for handling XUL extensions.
#
# Copyright: © 2010 Mike Hommey
# License: GPL-2+

package Debian::Debhelper::Buildsystem::xul_ext;

use strict;
use base 'Debian::Debhelper::Buildsystem';
use Debian::Debhelper::Dh_Lib;

sub DESCRIPTION {
	"XUL Extensions"
}

sub check_auto_buildable {
	my $this=shift;
	return (-e $this->get_sourcepath("install.rdf")) ? 1 : 0;
}

sub new {
	my $class=shift;
	my $this=$class->SUPER::new(@_);
	$this->enforce_in_source_building();
	return $this;
}

sub build {
	my $this=shift;
	$this->doit_in_sourcedir("xpi-pack", ".", $dh{FIRSTPACKAGE} . ".xpi");
}

sub install {
	my $this=shift;
	# the first param dh_auto_install gives us is the source
	# directory; if we shift it off, @_ contains everything passed
	# by the user after '--', which we pass to install-xpi as
	# dh_auto_install(1) claims
	shift;
	$this->doit_in_sourcedir("install-xpi", @_, $dh{FIRSTPACKAGE} . ".xpi");
}

sub clean {
	my $this=shift;
	$this->doit_in_sourcedir("rm", "-f", $dh{FIRSTPACKAGE} . ".xpi");
}

1
