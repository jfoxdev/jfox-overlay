# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils git-r3

DESCRIPTION="RomRaider is a free, open source tuning suite created for viewing, 
logging and tuning of modern Subaru Engine Control Units."
HOMEPAGE="https://github.com/RomRaider/RomRaider"
#SRC_URI=""
EGIT_REPO_URI="https://github.com/RomRaider/RomRaider.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
REQUIRED_USE=""
LANGS=""

DEPEND=""
RDEPEND="${DEPEND}"

EGIT_CHECKOUT_DIR=${WORKDIR}
S=${EGIT_CHECKOUT_DIR}


src_prepare() {
	git clone ${EGIT_REPO_URI} ${EGIT_CHECKOUT_DIR}
	return
}

src_compile() {
	ant build || die "ant build failed"
}

src_install() {
	
	# Install RomRaider.jar
	exeinto "/usr/share/${PF}/"
	doexe "${S}/build/linux/lib/RomRaider.jar"
	doexe "${S}/run.sh"
	dosym "/usr/share/${PF}/run.sh" "/usr/bin/RomRaider"

	
	# Install Plugins
	#TMP="${S}/plugins"

}


pkg_postinst() {
	return
}


