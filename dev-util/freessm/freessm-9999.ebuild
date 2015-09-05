# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
LANGS="en de"
inherit git-r3 qt4-r2 qmake-utils

DESCRIPTION="FreeSSM is a free and easy to use diagnostic and adjustment tool for SUBARU vehicles."
HOMEPAGE="https://github.com/Comer352L/FreeSSM"
SRC_URI=""
EGIT_REPO_URI="https://github.com/Comer352L/FreeSSM.git"

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

EGIT_CHECKOUT_DIR=${WORKDIR}
S=${EGIT_CHECKOUT_DIR}
QCONFIG_DEFINE="__linux__"

src_prepare() {
	git clone ${EGIT_REPO_URI} ${EGIT_CHECKOUT_DIR}
	qt4-r2_src_prepare
	epatch "${FILESDIR}/${P}-gentoo-installdir.patch"

	for lang in $LANGS; do
		if [ ! -e FreeSSM_$lang.ts ]; then
			ewarn "Language '$lang' no longer supported. Ebuild needs update."
		else
			use "linguas_$lang" && TRANSLATIONS="${TRANSLATIONS} FreeSSM_$lang.ts"
		fi
	done
	if [ -n "${TRANSLATIONS}" ]; then
		einfo "Building translation files."
		lrelease ${TRANSLATIONS}  || or die "lrelease failed"
	else
		einfo "No translations selected."
	fi
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
