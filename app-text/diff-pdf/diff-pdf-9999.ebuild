# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils git-r3 autotools autotools-utils wxwidgets

DESCRIPTION="A simple tool for visually comparing two PDF files."
HOMEPAGE="https://github.com/vslavik/diff-pdf"
#SRC_URI=""
EGIT_REPO_URI="https://github.com/vslavik/diff-pdf.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
REQUIRED_USE=""
LANGS=""

DEPEND="
	>=x11-libs/wxGTK-2.8.11:*
	>=x11-libs/cairo-1.4[glib]
	>=app-text/poppler-0.10[cairo,jpeg,png]
"

RDEPEND="${DEPEND}"

EGIT_CHECKOUT_DIR=${WORKDIR}
S=${EGIT_CHECKOUT_DIR}

AC_M4DIR="${S}"
AC_CONFIG_SUBDIRS="${S}/admin"

AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=(AUTHORS COPYING COPYING.icons README)

src_unpack() {
	git clone ${EGIT_REPO_URI} ${EGIT_CHECKOUT_DIR}
}

src_prepare() {
	eaclocal
	eautoconf
	eautoreconf
}

src_configure() {
	autotools-utils_src_configure
}

src_compile() {
	autotools-utils_src_compile
}

src_install() {
	autotools-utils_src_install
}
