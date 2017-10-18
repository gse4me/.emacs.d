;;; Emacs version check
(defmacro >=e (version &rest body)
  "Emacs VERSION check wrapper around BODY.
BODY can contain both `if' block (for stuff to execute if emacs
is equal or newer than VERSION) and `else' block (for stuff to
execute if emacs is older than VERSION).
Example:
  (>=e \"25.0\"
      (defun-compatible-with-25.0)
    (defun-not-compatible-in-older-version))"
  (declare (indent 2))          ;`if'-style indentation where this macro is used
  `(if (version<= ,version emacs-version)
       ,@body))

(>=e "25.0"
    (setq package-menu-async t)) ; If non-nil, do activities asynchronously, like refreshing menu

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org"          . "http://orgmode.org/elpa/")))

(setq quelpa-self-upgrade-p nil)
(setq quelpa-update-melpa-p nil)
(setq quelpa-checkout-melpa-p nil)



;; Install use-package if not yet installed.
(eval-when-compile
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
    )
  ;; to install directly from git
  (unless (require 'quelpa nil t)
    (with-temp-buffer
      (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el")
      (eval-buffer)))  
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; (if (require 'quelpa nil t)							       ;;
  ;;     (quelpa-self-upgrade)								       ;;
  ;;   (with-temp-buffer								       ;;
  ;;     (url-insert-file-contents "https://raw.github.com/quelpa/quelpa/master/bootstrap.el") ;;
  ;;     (eval-buffer)))								       ;;
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  )

(setq use-package-verbose t)
(setq use-package-always-ensure t)
(if (daemonp)
    (setq use-package-always-demand t))


(use-package bind-key)
(use-package diminish)




(quelpa
 '(quelpa-use-package
   :fetcher github
   :repo "quelpa/quelpa-use-package"))
(require 'quelpa-use-package)




(provide 'config-package)
