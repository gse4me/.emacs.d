(use-package-with-elpa)

(defun indent-or-complete ()
  "Indent or complete via company-mode."
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))




(use-package company
  :diminish company-mode
  :bind ("TAB" . company-indent-or-complete-common)
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (setq
   ;;company-show-numbers t
   company-require-match 'never
   company-tooltip-idle-delay 0.5
   company-tooltip-limit 15
   company-dabbrev-downcase 0
   company-async-timeout 10
   ;;company-async-wait 0.5
   )
  )


  (use-package company-quickhelp          ; Documentation popups for Company
    :defer t
    :if window-system
    :init (add-hook 'global-company-mode-hook #'company-quickhelp-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (use-package dashboard	     ;;
;;   :config			     ;;
;;   (dashboard-setup-startup-hook)) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ediff
  :defer t
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  (setq-default ediff-highlight-all-diffs 'nil)
  (setq ediff-diff-options "-w")
  (setq ediff-split-window-function 'split-window-horizontally)
  )

(use-package expand-region
  :bind
  ("C-=" . er/expand-region))

(use-package flycheck
  :commands flycheck-mode
  )

;; (use-package hlinum
;;   :config
;;   (hlinum-activate))

;; (use-package linum
;;   :config
;;   (setq linum-format " %4d ")
;;   (setq linum-delay t)
;;   ;;(global-linum-mode nil)
;;   )


(use-package nlinum
  :init
  (defface nlinum-current-line
    '((t :inherit linum :weight bold :foreground "green"))
    "Face for displaying current line.")
  :bind
  ([f3] . nlinum-mode)
  :config
  (setq  nlinum-highlight-current-line t)
  (setq nlinum-format " %d ")
  )



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

(use-package magit-popup
  :after magit)


(use-package p4
  :demand t
  :bind-keymap (("C-x p" . p4-prefix-map))
  ;; :config
  ;;(setq p4-do-find-file nil )
  )


(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" . mc/edit-lines)
  ("C->" . mc/mark-next-like-this)
  ("C-<" . mc/mark-previous-like-this)
  ("C-c C->" . mc/mark-all-like-this)
  )

(use-package eldoc
  :defer t
  :diminish eldoc-mode
  )

(use-package abbrev
  :defer t
  :ensure nil
  :diminish abbrev-mode
  )

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



(use-package recentf
  :config
  (setq recentf-save-file (expand-file-name "recentf" my-savefile-dir))
  (recentf-mode 1))

(use-package smartparens)

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  ;; Remember undo history
  (setq
   undo-tree-auto-save-history nil
   undo-tree-history-directory-alist `(("." . ,(concat user-emacs-directory "/undo/"))))
  (global-undo-tree-mode 1))



(use-package windmove
  :bind
  ("C-x <up>" . windmove-up)
  ("C-x <down>" . windmove-down)
  ("C-x <left>" . windmove-left)
  ("C-x <right>" . windmove-right))


(use-package grep
  :defer t
  :config
  (nconc grep-find-ignored-files
         '("TAGS" "GTAGS" "GRTAGS" "GSYMS" "GPATH" "GTAGSROOT"))

  (use-package wgrep :defer t)
  )





(use-package yasnippet
  :defer t
  :init
  (add-hook 'python-mode #'yas-minor-mode)
  :config (yas-reload-all))


(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode))

;; Use nasm-mode because it provides better x86 formatting
;;(use-package nasm-mode
;;  :mode "\\.asm")



(use-package verilog-mode
  :load-path "~/.emacs.d/git_edits/verilog-mode"
  :mode (("\\.[st]*v[hp]*\\'" . verilog-mode) ; .v, .sv, .svh, .tv, .vp
         ("\\.psl\\'"         . verilog-mode)  ; .psl
         ("\\.[xd]\\'"        . verilog-mode) ; .x, .d
	 ("\\.decl\\'"        . verilog-mode)) ; .decl

  ;;:config
  ;;   ;; User customization for Verilog mode
  ;;   (setq verilog-indent-level             3
  ;;         verilog-indent-level-module      3
  ;;         verilog-indent-level-declaration 3
  ;;         verilog-indent-level-behavioral  3
  ;;         verilog-indent-level-directive   1
  ;;         verilog-case-indent              2
  ;;         verilog-auto-newline             t
  ;;         verilog-auto-indent-on-newline   t
  ;;         verilog-tab-always-indent        t
  ;;         verilog-auto-endcomments         t
  ;;         verilog-minimum-comment-distance 40
  ;;         verilog-indent-begin-after-if    t
  ;;         verilog-auto-lineup              'declarations
  ;;         verilog-highlight-p1800-keywords nil
  ;;         verilog-linter                   "my_lint_shell_command"
  ;;         )
  )

(use-package aggressive-indent
  :init
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'clojure-mode-hook #'aggressive-indent-mode))



(use-package elisp-slime-nav
  :init
  (add-hook 'emacs-lisp-mode-hook 'elisp-slime-nav-mode))


(provide 'config-extensions)
