# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils flag-o-matic

DESCRIPTION="RomRaider is a free, open source tuning suite created for viewing, 
logging and tuning of modern Subaru Engine Control Units."
HOMEPAGE="https://github.com/RomRaider/RomRaider"
SRC_URI="https://github.com/RomRaider/RomRaider/archive/0.5.9-RC2.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
LANGS=""

REQUIRED_USE=""
DEPEND="dev-java/ant-core"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_prepare() {
	unpack "${PF}.tar.gz"
	return
}

src_compile() {
	return
}

src_install() {
	return
}


pkg_postinst() {
	return
}


