# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"
inherit eutils git-r3 java-pkg-2 java-ant-2 flag-o-matic

DESCRIPTION="RomRaider is a tuning suite for viewing, logging and tuning modern Subaru Engine Control Units."
HOMEPAGE="https://github.com/RomRaider/RomRaider"
#SRC_URI=""
EGIT_REPO_URI="https://github.com/RomRaider/RomRaider.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
REQUIRED_USE=""
LANGS=""

REQUIRED_USE=""
DEPEND="
	>=virtual/jdk-1.7
	dev-java/log4j
	dev-java/ant-core
"
RDEPEND="
	>=virtual/jre-1.7
"
EGIT_CHECKOUT_DIR=${WORKDIR}
S=${EGIT_CHECKOUT_DIR}
EANT_BUILD_XML="${S}/build.xml"
EANT_BUILD_TARGET="build"
#JAVA_ANT_REWRITE_CLASSPATH="true"
#JAVA_ANT_IGNORE_SYSTEM_CLASSES="true"
#EANT_DOC_TARGET=""

src_prepare() {
	java-pkg-2_src_prepare
}
src_compile() {
	java-pkg-2_src_compile
}

src_install() {
	#java-pkg_newjar "${S}/build/linux/lib/RomRaider.jar" RomRaider.jar

	if use doc; then
		java-pkg_dojavadoc "${S}/build/javadoc"
	fi

	insinto "/usr/share/${PF}"
	doins "${S}/build/linux/lib/RomRaider.jar"
	insinto "/usr/share/${PF}/lib/common"
	doins "${S}/lib/common/"*.jar
	insinto "/usr/share/${PF}/lib/linux"
	doins "${S}/lib/linux/"*.jar

	# Update the run script
	sed -i "s/RomRaider.jar/\/usr\/share\/${PF}\/RomRaider.jar/" "${S}/run.sh"

	exeinto "/usr/share/${PF}"
	doexe "${S}/run.sh"
	dosym "/usr/share/${PF}/run.sh" "/usr/bin/RomRaider"
}
