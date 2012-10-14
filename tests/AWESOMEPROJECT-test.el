
(require 'ert)

;; (require 'popup)

;; for "every" function
(require 'cl)

(defmacro AWESOMEPROJECT-test-with-test-buffer (&rest body)
  (declare (indent 0) (debug t))
  `(let ((test-buffer-name "*AWESOME test*"))
     (save-excursion
       (when (get-buffer test-buffer-name)
         (kill-buffer test-buffer-name))
       (switch-to-buffer (get-buffer-create test-buffer-name))
       ,@body)))

(defmacro AWESOMEPROJECT-test-with-common-setup (&rest body)
  (declare (indent 0) (debug t))
  `(AWESOMEPROJECT-test-with-test-buffer
    ,@body))


(ert-deftest AWESOMEPROJECT-test-sanity ()
  "sanity check."
  (AWESOMEPROJECT-test-with-common-setup
    (insert "a b c")
    (execute-kbd-macro (read-kbd-macro "M-DEL"))
    (should (every #'identity (list 1 2 3)))
    (should (string-equal (buffer-string) "a b "))))
