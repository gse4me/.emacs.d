
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

;; git-gutter alternative for tools implementing vcs (p4 does not)
;; (use-package diff-hl
;;   :init
;;   (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
;;   )

(use-package git-gutter
  :defer t
  :load-path "~/.emacs.d/git_edits/emacs-git-gutter/"
  :init
  (setq git-gutter:p4_ex "/tool/pandora64/.package/perforce-2016.1/bin/p4") 
  ;; :config
  ;; (git-gutter:linum-setup)
  )

(use-package git-gutter-fringe
  :defer t
  )

(use-package p4  
  :init
  (setq p4-executable "/tool/pandora64/.package/perforce-2016.1/bin/p4")
  (setq p4-global-key-prefix (kbd "C-x p"))
  :config
  ;;(setq p4-do-find-file nil )
  (add-hook 'p4-mode-hook
	    (lambda () (add-hook 'read-only-mode-hook 'gse-p4-edit-if-necessary nil t)))
  
  )


(provide 'config-vcs)
