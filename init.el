;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Increase gc-cons-threshold, depending on your system you may set it back to a lower value
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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; use one folder for all save/history/cache files
(defconst my-savefile-dir (concat "/tmp/.em." (user-login-name)))
(unless (file-exists-p my-savefile-dir)
  (make-directory my-savefile-dir))

;; look in the main config folder
(add-to-list 'load-path (concat user-emacs-directory "config"))


(let ((file-name-handler-alist nil))
  (require 'config-paths)
  (require 'config-package) 
  (require 'config-package-extra)
  (require 'config-base)
  (require 'config-theme)
  (require 'config-extensions)
  (require 'config-org)
  (require 'config-ivy)
  (require 'config-vcs) ;;git/p4
  (require 'config-functions)
  (require 'config-search)
  (require 'config-projects)
  (require 'config-tree)
  ;;---choose one modeline-------------
  ;;(require 'config-modeline-sml)
  (require 'config-modeline-spaceline)
  ;;-----------------------------------
  (require 'config-font-lock)

  ;;lang support
  (require 'lang-python)
  ;;(require 'lang-cpp)
  ;;(require 'lang-ruby)
  (require 'lang-cpp-rtags)
  (require 'lang-yaml)
  ;;(require 'lang-ruby)
  
  (require 'config-global-keys)
  (require 'config-work)
  ;; (require 'config-evil)
  (require 'config-hydras)
  )
