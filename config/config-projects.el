;;(use-package-with-elpa)


(use-package projectile
  :load-path "~/.emacs.d/git_edits/projectile"
  ;; :defer 0.2
  :diminish projectile-mode
  :init
  (setq projectile-enable-caching t
	projectile-completion-system 'ivy
	projectile-use-git-grep t
	projectile-cache-file (expand-file-name  "projectile.cache" my-savefile-dir)
	projectile-known-projects-file (expand-file-name "projectile-bookmarks.eld" my-savefile-dir)
	;;projectile-mode-line '(:eval (format " [%s] " (projectile-project-name)))
	;; projectile-mode-line '(:eval (list " ["
	;; 				   (propertize (projectile-project-name)
	;; 					       'face '(:foreground "#e5e500"))
	;; 				   "] "))
	)
  :config
  (progn
    ;;(add-to-list 'projectile-project-root-files "P4CONFIG")
    (add-to-list 'projectile-project-root-files "init.el")
    (projectile-mode)
    )
  )


(use-package counsel-projectile
  :defer t
  :after projectilex
  :init (counsel-projectile-on))

(use-package ibuffer-projectile         ; Group buffers by Projectile project
  :defer t
  :init (add-hook 'ibuffer-hook #'ibuffer-projectile-set-filter-groups)
  :config
  (setq ibuffer-projectile-prefix "")
  )

;; (use-package ibuffer-vc         ;
;;   :defer t
;;   :init (add-hook 'ibuffer-hook #'ibuffer-vc-set-filter-groups-by-vc-root))


(use-package dashboard
  :config
  (setq
   dashboard-startup-banner nil
   dashboard-items '((recents  . 10)
		     (projects . 10)
		     (bookmarks . 10)
		     ))
  (dashboard-setup-startup-hook)

  )

(use-package ag)

(provide 'config-projects)
