# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
AUTOTOOLS_AUTORECONF="yes"
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
	>=x11-libs/wxGTK-2.8.11:2.8[X]
	>=x11-libs/cairo-1.4[glib]
	>=app-text/poppler-0.10:=[cairo,jpeg,png]
"

RDEPEND="${DEPEND}"

DOCS=(AUTHORS COPYING COPYING.icons README)

src_configure() {
	WX_GTK_VER=2.8 need-wxwidgets unicode
	autotools-utils_src_configure
}
