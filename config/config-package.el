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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Little bit opinionated helper function for package.el users
;;


;;;###autoloadi
(defmacro use-package-with-elpa ()
  "Set up use-package to optimal usage with package.el.
For full documentation on the meaning and usage fo this, please
consult the README file that came with this file at the section
called `Byte-compiling with Package.el'."
  '(progn
     ;; Disable package initialize after us.  We either initialize it
     ;; anyway in case of interpreted .emacs, or we don't want slow
     ;; initizlization in case of byte-compiled .emacs.elc.
     (setq package-enable-at-startup nil)
     ;; Set use-package-verbose to t for interpreted .emacs,
     ;; and to nil for byte-compiled .emacs.elc.
     (eval-and-compile
       (setq use-package-verbose (not (bound-and-true-p byte-compile-current-file))))
     ;; Add the macro generated list of package.el loadpaths to load-path.
     (mapc (lambda (add) (add-to-list 'load-path add))
           (eval-when-compile
             (setq use-package-always-ensure t)
             (let ((package-user-dir-real (file-truename package-user-dir)))
               ;; The reverse is necessary, because outside we mapc
               ;; add-to-list element-by-element, which reverses.
               (nreverse (apply #'nconc
                                ;; Only keep package.el provided loadpaths.
                                (mapcar (lambda (path)
                                          (if (string-prefix-p package-user-dir-real path)
                                              (list path)
                                            nil))
                                        load-path))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(>=e "25.0"
    (setq package-menu-async t)) ; If non-nil, do activities asynchronously, like refreshing menu

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("org"          . "http://orgmode.org/elpa/")))


;; Install use-package if not yet installed.
(eval-when-compile
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
    ))

(use-package-with-elpa)


(use-package bind-key)
(use-package diminish)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (package-initialize)			      ;;
;; ;; * Package helpers			      ;;
;; ;; ** use-package			      ;;
;; 					      ;;
;; (unless (package-installed-p 'use-package) ;;
;;   (package-refresh-contents)		      ;;
;;   (package-install 'use-package))	      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






(provide 'config-package)
