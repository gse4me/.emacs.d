
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

;; Increase gc-cons-threshold, depending on your system you may set it back to a lower value
(setq gc-cons-threshold 100000000)



(add-to-list 'load-path (concat user-emacs-directory "config"))


(require 'config-package)
(require 'config-base)
(require 'config-theme)
(require 'config-extensions)
(require 'config-ivy)
(require 'config-functions)
(require 'config-search)
(require 'config-modeline-sml)
(require 'config-global-keys)

(require 'lang-python)
;(require 'lang-ruby)
