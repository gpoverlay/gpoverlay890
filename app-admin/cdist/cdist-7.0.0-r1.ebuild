# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A usable configuration management system"
HOMEPAGE="https://www.cdi.st/ https://code.ungleich.ch/ungleich-public/cdist"
SRC_URI="https://code.ungleich.ch/ungleich-public/cdist/archive/${PV}.tar.gz -> ${P}.ug.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

distutils_enable_sphinx docs/src \
	dev-python/sphinx-rtd-theme \
	dev-python/six
distutils_enable_tests unittest

python_prepare_all() {
	echo "VERSION='${PV}'" > cdist/version.py || die "Failed to set version"
	distutils-r1_python_prepare_all
}
