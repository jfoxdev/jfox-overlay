# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils flag-o-matic qmake-utils

DESCRIPTION="FreeSSM is a free and easy to use diagnostic and adjustment tool for SUBARU vehicles."
HOMEPAGE="https://github.com/Comer352L/FreeSSM"
SRC_URI="https://github.com/Comer352L/FreeSSM/archive/v${PVR}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc qt4 qt5 linguas_en linguas_de"
LANGS="en de"
inherit qt4-r2

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
EQMAKE4_EXCLUDE="FreeSSM-1.2.5/src/windows/*" 

src_prepare() {

    patch "${S}/FreeSSM-1.2.5/src/SSMP2communication_core.h" "${FILESDIR}/${P}-SSMP2communication_core.patch" 
    patch "${S}/FreeSSM-1.2.5/src/linux/serialCOM.cpp" "${FILESDIR}/${P}-serialCOM.patch" 
	
	qmake -project 
	
	if use linguas_en; then
		TRANSLATIONS="${TRANSLATIONS} FreeSSM-1.2.5/FreeSSM_en.ts"
	fi
	if use linguas_de; then
		TRANSLATIONS="${TRANSLATIONS} FreeSSM-1.2.5/FreeSSM_de.ts"
	fi
	
	lrelease FreeSSM-1.2.5/FreeSSM.pro || or die "lrelease failed"
	
	qmake -makefile
}

src_compile() {
	eqmake4 FreeSSM-1.2.5/FreeSSM.pro || or die "eqmake4 failed"
	make
}

src_install() {
	
	exeinto "/usr/share/${PF}/"
	doexe "${S}/FreeSSM"
	dosym "/usr/share/${PF}/FreeSSM" "/usr/bin/FreeSSM"
	
	insinto "/usr/share/${PF}/"
	if use linguas_en; then
		doins "${S}/FreeSSM-1.2.5/FreeSSM_en.qm"
	fi
	if use linguas_de; then
		doins "${S}/FreeSSM-1.2.5/FreeSSM_de.qm"
	fi
	
	doins "${S}/FreeSSM-1.2.5/background.png" 
	doicon -s 48 "${S}/FreeSSM-1.2.5/resources/icons/freessm/48x48/FreeSSM.png"

	doins "${S}/FreeSSM-1.2.5/LiberationSans-Bold.ttf"
	doins "${S}/FreeSSM-1.2.5/LiberationSans-BoldItalic.ttf"
	doins "${S}/FreeSSM-1.2.5/LiberationSans-Italic.ttf"
	doins "${S}/FreeSSM-1.2.5/LiberationSans-Regular.ttf"
	
	if use doc; then
		dodoc "${S}/FreeSSM-1.2.5/doc/bg.jpg"
		dodoc "${S}/FreeSSM-1.2.5/doc/help_en.html"
		dodoc "${S}/FreeSSM-1.2.5/doc/help_de.html"
		dosym "/usr/share/doc/${PF}" "/usr/share/${PF}/doc" 
	fi

}


pkg_postinst() {
	
	if ! use linguas_en; then
		ewarn "FreeSSM may complain about a missing language file."
		ewarn "Compile with USE='linguas_en' to satisfy this need."
	fi	
	if ! use linguas_de; then
		ewarn "FreeSSM may complain about a missing language file."
		ewarn "Compile with USE='linguas_de' to satisfy this need."
	fi
}


