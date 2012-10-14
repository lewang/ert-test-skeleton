;; Usage:
;;
;;   emacs -Q -l tests/run-test.el           # interactive mode
;;   emacs -batch -Q -l tests/run-test.el    # batch mode


;; Utils
(defun AWESOMEPROJECT-test-join-path (path &rest rest)
  "Join a list of PATHS with appropriate separator (such as /).

\(fn &rest paths)"
  (if rest
      (concat (file-name-as-directory path) (apply 'AWESOMEPROJECT-test-join-path rest))
    path))

(defvar AWESOMEPROJECT-test-dir (file-name-directory load-file-name))
(defvar AWESOMEPROJECT-root-dir (file-name-as-directory (expand-file-name ".." AWESOMEPROJECT-test-dir)))


;; Setup `load-path'
(mapc (lambda (p) (add-to-list 'load-path p))
      (list AWESOMEPROJECT-test-dir
            AWESOMEPROJECT-root-dir))


;; Use ERT from github when this Emacs does not have it
(unless (locate-library "ert")
  (let ((default-directory AWESOMEPROJECT-root-dir))
    (shell-command "git clone git://github.com/ohler/ert.git lib/ert"))
  (add-to-list
   'load-path
   (AWESOMEPROJECT-test-join-path AWESOMEPROJECT-root-dir "lib" "ert" "lisp" "emacs-lisp"))
  (require 'ert-batch)
  (require 'ert-ui))


;; Load tests
(load "AWESOMEPROJECT-test")


;; Run tests
(if noninteractive
    (ert-run-tests-batch-and-exit)
  (ert t))
