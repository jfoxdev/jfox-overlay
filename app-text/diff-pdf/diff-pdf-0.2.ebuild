# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils autotools autotools-utils wxwidgets

DESCRIPTION="A simple tool for visually comparing two PDF files."
HOMEPAGE="https://github.com/vslavik/diff-pdf"
SRC_URI="https://github.com/vslavik/diff-pdf/archive/v0.2.tar.gz -> ${PF}.tar.gz"

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

S=${WORKDIR}/diff-pdf-0.2

AC_M4DIR="${S}"
AC_CONFIG_SUBDIRS="${S}/admin"

AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=(AUTHORS COPYING COPYING.icons README)

src_unpack() {
	unpack ${PF}.tar.gz
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
