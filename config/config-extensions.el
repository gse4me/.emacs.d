

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package dashboard	     ;;
;;   :config			     ;;
;;   (dashboard-setup-startup-hook)) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ediff
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w")
  (setq ediff-split-window-function 'split-window-horizontally)
  )

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck)

(use-package hlinum
  :config
  (hlinum-activate))

(use-package linum
  :config
  (setq linum-format " %3d ")
  (global-linum-mode nil))

(use-package magit
  :config

  (setq magit-completing-read-function 'ivy-completing-read)

  :bind
  ;; Magic
  ("C-x g s" . magit-status)
  ("C-x g x" . magit-checkout)
  ("C-x g c" . magit-commit)
  ("C-x g p" . magit-push)
  ("C-x g u" . magit-pull)
  ("C-x g e" . magit-ediff-resolve)
  ("C-x g r" . magit-rebase-interactive))

(use-package magit-popup)

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this))

(use-package treemacs
  :ensure t
  :defer t
  :config
  (setq treemacs-header-function            #'treemacs--create-header
        treemacs-follow-after-init          t
        treemacs-width                      35
        treemacs-indentation                2
        treemacs-git-integration            t
        treemacs-change-root-without-asking nil
        treemacs-sorting                    'alphabetic-desc
        treemacs-show-hidden-files          t
        treemacs-never-persist              nil)
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t)
  :bind
  (:map global-map
   ([f8]        . treemacs-toggle)
   ("<C-M-tab>" . treemacs-toggle)
  ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package neotree					      ;;
;;   :config						      ;;
;;   (setq neo-theme 'arrow ; 'classic, 'nerd, 'ascii, 'arrow ;;
;; 							      ;;
;;         neotree-smart-open t				      ;;
;;         neo-window-fixed-size nil)			      ;;
;;   ;; Disable linum for neotree			      ;;
;;   ;(add-hook 'neo-after-create-hook 'disable-neotree-hook) ;;
;;   )							      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package org									   ;;
;;   :config										   ;;
;;   (setq org-directory "~/org-files"							   ;;
;;         org-default-notes-file (concat org-directory "/todo.org"))			   ;;
;;   :bind										   ;;
;;   ("C-c l" . org-store-link)								   ;;
;;   ("C-c a" . org-agenda))								   ;;
;; 											   ;;
;; (use-package org-projectile								   ;;
;;   :config										   ;;
;;   (org-projectile:per-repo)								   ;;
;;   (setq org-projectile:per-repo-filename "todo.org"					   ;;
;; 	org-agenda-files (append org-agenda-files (org-projectile:todo-files))))	   ;;
;; 											   ;;
;; (use-package org-bullets								   ;;
;;   :config										   ;;
;;   (setq org-hide-leading-stars t)							   ;;
;;   (add-hook 'org-mode-hook								   ;;
;;             (lambda ()								   ;;
;;               (org-bullets-mode t))))						   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package page-break-lines)

(use-package projectile
  :config
  (setq projectile-known-projects-file
        (expand-file-name "projectile-bookmarks.eld" temp-dir))

  (setq projectile-completion-system 'ivy)

  (projectile-mode))

(use-package recentf
  :config
  (setq recentf-save-file (recentf-expand-file-name "~/.emacs.d/private/cache/recentf"))
  (recentf-mode 1))

(use-package smartparens)

(use-package undo-tree
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat temp-dir "/undo/"))))
  (global-undo-tree-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package windmove
  :bind
  ("C-x <up>" . windmove-up)
  ("C-x <down>" . windmove-down)
  ("C-x <left>" . windmove-left)
  ("C-x <right>" . windmove-right))

(use-package wgrep)

(use-package yasnippet
  :config
  (yas-global-mode 1))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package mwheel							    ;;
;;   :defer t								    ;;
;;   :config								    ;;
;;   ;; Smooth-ish mouse scrolling					    ;;
;;   (setq mouse-wheel-progressive-speed nil				    ;;
;;         mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil)))) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(provide 'config-extensions)
