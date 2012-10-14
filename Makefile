EMACS=emacs
EMACS23=emacs23

.PHONY: test test-nw test-emacs23 test-emacs23-nw travis-ci show-version

show-version: show-version
	echo "*** Emacs version ***"
	echo "EMACS = `which ${EMACS}`"
	${EMACS} --version

test: show-version
	${EMACS} -Q -L . -l tests/run-test.el

test-nw: show-version
	${EMACS} -Q -nw -L . -l tests/run-test.el

travis-ci: show-version
	${EMACS} -batch -Q -l tests/run-test.el
