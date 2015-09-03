# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

#
# REMOVE ME
# https://wiki.gentoo.org/wiki/Project:Games/Ebuild_howto#Creating_a_games_ebuild_in_your_overlay

EAPI=5
inherit git-r3

DESCRIPTION="FreeSSM is a free and easy to use diagnostic and adjustment tool for SUBARU vehicles."
HOMEPAGE="https://github.com/Comer352L/FreeSSM"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Comer352L/FreeSSM.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="qt4 qt5 linguas_en linguas_de"
REQUIRED_USE="|| ( qt4 qt5 )"
LANGS="en de"
inherit qt4-r2 qmake-utils

DEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
	)
	qt5? (
		dev-qt/core:5
		dev-qt/qtgui:5
	)
"
RDEPEND="${DEPEND}"

EGIT_CHECKOUT_DIR=${WORKDIR}
S=${EGIT_CHECKOUT_DIR}

#EQMAKE4_EXCLUDE="src/windows/*" 



src_prepare() {
	git clone ${EGIT_REPO_URI} ${EGIT_CHECKOUT_DIR}

	#patch "${S}/src/SSMP2communication_core.h" "${FILESDIR}/${P}-SSMP2communication_core.patch" 
    #patch "${S}/src/linux/serialCOM.cpp" "${FILESDIR}/${P}-serialCOM.patch" 
	
	
	qmake -project 
	
	if use linguas_en; then
		TRANSLATIONS="${TRANSLATIONS} FreeSSM_en.ts"
	fi
	if use linguas_de; then
		TRANSLATIONS="${TRANSLATIONS} FreeSSM_de.ts"
	fi
	
	lrelease FreeSSM.pro || or die "lrelease failed"
	
	qmake -makefile
}

src_compile() {
	eqmake4 FreeSSM.pro || or die "eqmake4 failed"
	make
}

src_install() {
	
	#emake DESTDIR="/usr/share/${P}" install
	
	exeinto "/usr/share/${P}/"
	doexe "${S}/FreeSSM"
	dosym "/usr/share/${P}/FreeSSM" "/usr/bin/FreeSSM"
	
	insinto "/usr/share/${P}/"
	if use linguas_en; then
		doins "${S}/FreeSSM_en.qm"
	fi
	if use linguas_de; then
		doins "${S}/FreeSSM_de.qm"
	fi
	
	doins "${S}/background.png" 
	doicon -s 48 "${S}/resources/icons/freessm/48x48/FreeSSM.png"

	doins "${S}/LiberationSans-Bold.ttf"
	doins "${S}/LiberationSans-BoldItalic.ttf"
	doins "${S}/LiberationSans-Italic.ttf"
	doins "${S}/LiberationSans-Regular.ttf"
	
	insinto "/usr/share/${P}/doc/"
	doins "${S}/doc/bg.jpg"
	doins "${S}/doc/help_en.html"
	doins "${S}/doc/help_de.html"

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


