;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
					;(package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a lower value
;;(setq gc-cons-threshold 100000000)

(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'after-init-hook #'(lambda ()
			       ;; restore after startup
                               (setq gc-cons-threshold 8000000)))


(defun my-minibuffer-setup-hook ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun my-minibuffer-exit-hook ()
  (setq gc-cons-threshold 8000000))

(add-hook 'minibuffer-setup-hook #'my-minibuffer-setup-hook)
(add-hook 'minibuffer-exit-hook #'my-minibuffer-exit-hook)


(add-to-list 'load-path (concat user-emacs-directory "config"))
(let ((file-name-handler-alist nil))
  (require 'config-package)
  (require 'config-package-extra)
  (require 'config-base)
  (require 'config-theme)
  (require 'config-extensions)
  (require 'config-ivy)
  (require 'config-functions)
  (require 'config-search)
  (require 'config-projects)
  ;;(require 'config-modeline-sml)
  (require 'config-modeline-spaceline)
  (require 'config-font-lock)

  ;;(require 'lang-python)
  ;;(require 'lang-cpp)
  ;;(require 'lang-ruby)
  (require 'lang-cpp-rtags)
  (require 'lang-yaml)

  (require 'config-global-keys)
  (require 'config-work)

  )
;;(require 'lang-ruby)

;;(setq scroll-conservatively 101) ;; move minimum when cursor exits view, instead of recentering
;;(setq mouse-wheel-scroll-amount '(1)) ;; mouse scroll moves 1 line at a time, instead of 5 lines
;;(setq mouse-wheel-progressive-speed nil) ;; on a long mouse scroll keep scrolling by 1 line
