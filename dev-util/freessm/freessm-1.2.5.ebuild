# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
LANGS="en de"
inherit eutils qmake-utils qt4-r2 flag-o-matic
DESCRIPTION="FreeSSM is a free and easy to use diagnostic and adjustment tool for SUBARU vehicles."
HOMEPAGE="https://github.com/Comer352L/FreeSSM"
SRC_URI="https://github.com/Comer352L/FreeSSM/archive/v${PVR}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"
DEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
	)
"
RDEPEND="${DEPEND}"

S=${WORKDIR}
#EQMAKE4_EXCLUDE="FreeSSM-1.2.5/src/windows/*"
QCONFIG_DEFINE="__linux__"

src_prepare() {
	qt4-r2_src_prepare
	epatch "${FILESDIR}/${P}-SSMP2communication_core.patch"
	epatch "${FILESDIR}/${P}-serialCOM.patch"
	epatch "${FILESDIR}/${P}-gentoo-installdir.patch"

	for lang in $LANGS; do
		if [ ! -e FreeSSM-1.2.5/FreeSSM_$lang.ts ]; then
			ewarn "Language '$lang' no longer supported. Ebuild needs update."
		else
			use "linguas_$lang" && TRANSLATIONS="${TRANSLATIONS} FreeSSM-1.2.5/FreeSSM_$lang.ts"
		fi
	done
	if [ -n "${TRANSLATIONS}" ]; then
		einfo "Building translation files."
		lrelease ${TRANSLATIONS}  || or die "lrelease failed"
	else
		einfo "No translations selected."
	fi
}

src_compile() {
	eqmake4 "${S}/FreeSSM-1.2.5/FreeSSM.pro"	
	
	qt4-r2_src_compile
}

src_install() {
	qt4-r2_src_install
	dosym "/usr/share/${PF}/FreeSSM" "/usr/bin/FreeSSM"
}

pkg_postinst() {
	
	for lang in $LANGS; do
		if ! use "linguas_${lang}"; then 
			NO_TRANSLATIONS="${NO_TRANSLATIONS} linguas_${lang}"
		fi
	done
	if [ -n "${NO_TRANSLATIONS}" ]; then
		ewarn "FreeSSM may complain about a missing language file."
		ewarn "Build with USE=\"${NO_TRANSLATIONS}\" to satisfy this need."
	fi
}
