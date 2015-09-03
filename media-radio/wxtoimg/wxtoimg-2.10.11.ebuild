# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils flag-o-matic

DESCRIPTION="WXtoImg is a fully automated APT and WEFAX weather satellite (wxsat) decoder."
HOMEPAGE="http://www.wxtoimg.com"
SRC_URI="
	x86? ( http://www.wxtoimg.com/downloads/wxtoimg-linux-${PVR}.tar.gz -> ${PF}-x86.tar.gz )
	amd64? ( http://www.wxtoimg.com/downloads/wxtoimg-linux64-2.10.11-1.tar.gz -> ${PF}-amd64.tar.gz )
"

LICENSE="freeware"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc linguas_en linguas_de linguas_es linguas_fr linguas_ja linguas_pl"
LANGS="de en es fr ja pl"

REQUIRED_USE=""
DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	if use x86; then
		unpack ${PF}-x86.tar.gz
	fi

	if use amd64; then
		unpack ${PF}-amd64.tar.gz
	fi
}

src_install() {
	
	#install bin/
	TMP="${S}/usr/local/bin"
	dobin "${TMP}/wxbatch"
	dobin "${TMP}/wxmap"
	dobin "${TMP}/wxproj"
	dobin "${TMP}/wxrec"
	dobin "${TMP}/wxtoimg"

	#install lib/
	insinto "/usr/share/${PF}/wx"
	TMP="${S}/usr/local/lib/wx"
	doins "${TMP}/template0.html"
	doins "${TMP}/template1.html"
	doins "${TMP}/template2.html"
	doins "${TMP}/template3.html"
	doins "${TMP}/template4.html"
	doins "${TMP}/template5.html"
	doins "${TMP}/template6.html"
	
	doins "${TMP}/wxmap.db"
	doins "${TMP}/wxland.png"
	doins "${TMP}/wxmap.png"
	doins "${TMP}/tkclscrd.ttf"

	insinto "/usr/share/${PF}/wx/tle"
	doins "${TMP}/tle/archive.txt"
	doins "${TMP}/tle/met2-21h.txt"
	doins "${TMP}/tle/met3-05h.txt"
	doins "${TMP}/tle/noaa-12h.txt"
	doins "${TMP}/tle/noaa-14h.txt"
	doins "${TMP}/tle/noaa-15h.txt"
	doins "${TMP}/tle/noaa-16h.txt"
	doins "${TMP}/tle/noaa-17h.txt"
	doins "${TMP}/tle/othertle.txt"
	doins "${TMP}/tle/resource.txt"
	doins "${TMP}/tle/weather.txt"
	
	#insinto "/usr/share/${PF}/wx/man"


	#install icon
	doicon "${S}/usr/share/icons/wxtoimg.xbm"
	
	#install desktop file
	domenu "${S}/etc/X11/applnk/Applications/wxtoimg.desktop"


	#install man/
	if use doc; then
			
		if use linguas_en; then
			TMP="${S}/usr/local/man/man1"
			doman "${TMP}/wxbatch.1"
			doman "${TMP}/wxmap.1"
			doman "${TMP}/wxproj.1"
			doman "${TMP}/wxrec.1"
			doman "${TMP}/wxtoimg.1"
		fi

		if use linguas_de; then
			TMP="${S}/usr/local/lib/wx/man"
			doman "${TMP}/de_wxcalibrate.1"
			doman "${TMP}/de_wxfaq.1"
			doman "${TMP}/de_wxrego.1"
			doman "${TMP}/de_xwxtoimg.1"
		fi
		if use linguas_es; then	
			TMP="${S}/usr/local/lib/wx/man"
			doman "${TMP}/es_wxcalibrate.1"
			doman "${TMP}/es_wxfaq.1"
			doman "${TMP}/es_wxrego.1"
			doman "${TMP}/es_xwxtoimg.1"
		fi
		if use linguas_fr; then		
			TMP="${S}/usr/local/lib/wx/man"
			doman "${TMP}/fr_wxcalibrate.1"
			doman "${TMP}/fr_wxfaq.1"
			doman "${TMP}/fr_wxrego.1"
			doman "${TMP}/fr_xwxtoimg.1"
		fi
		if use linguas_ja; then	
			TMP="${S}/usr/local/lib/wx/man"
			doman "${TMP}/ja_wxcalibrate.1"
			doman "${TMP}/ja_wxfaq.1"
			doman "${TMP}/ja_wxrego.1"
			doman "${TMP}/ja_xwxtoimg.1"
		fi
		if use linguas_pl; then	
			TMP="${S}/usr/local/lib/wx/man"
			doman "${TMP}/pl_wxcalibrate.1"
			doman "${TMP}/pl_wxfaq.1"
			doman "${TMP}/pl_wxrego.1"
			doman "${TMP}/pl_xwxtoimg.1"
		fi

	fi

}

