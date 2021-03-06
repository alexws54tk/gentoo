# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils

DESCRIPTION="Provides functionality for gaming input devices"

HOMEPAGE="https://sourceforge.net/projects/libgaminggear/"
SRC_URI="mirror://sourceforge/libgaminggear/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="
	>=dev-db/sqlite-3.17:3
	dev-libs/glib:2
	media-libs/libcanberra
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/pango
"

DEPEND="
	${RDEPEND}
	virtual/libgudev
	doc? ( app-doc/doxygen )
"

PATCHES=(
	"${FILESDIR}"/${PN}-0.10.0-doc.patch
)

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DDOCDIR=share/doc/${PF}
		-DWITH_DOC="$(usex doc)"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
