# Copyright 2019-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Library for testing asyncio code with pytest"
HOMEPAGE="
	https://github.com/pytest-dev/pytest-asyncio/
	https://pypi.org/project/pytest-asyncio/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~x64-macos"

RDEPEND="
	>=dev-python/pytest-8.2[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools-scm[${PYTHON_USEDEP}]
	test? (
		>=dev-python/hypothesis-5.7.1[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=(
		# rely on precise warning counts
		tests/hypothesis/test_base.py::test_can_use_explicit_event_loop_fixture
		tests/test_event_loop_fixture_finalizer.py::test_event_loop_fixture_finalizer_raises_warning_when_fixture_leaves_loop_unclosed
		tests/test_event_loop_fixture_finalizer.py::test_event_loop_fixture_finalizer_raises_warning_when_test_leaves_loop_unclosed
	)

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	local -x PYTEST_PLUGINS=pytest_asyncio.plugin,_hypothesis_pytestplugin
	epytest
}
