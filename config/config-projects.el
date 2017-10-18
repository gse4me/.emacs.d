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
    (add-to-list 'projectile-project-root-files "init.el")
    (projectile-mode)))


(use-package eyebrowse 
  :config
  (progn
    (setq eyebrowse-new-workspace "*dashboard*")
    (bind-key "C-c `" 'eyebrowse-last-window-config eyebrowse-mode-map)
    (bind-key "C-c 0" 'eyebrowse-switch-to-window-config-0 eyebrowse-mode-map)
    (bind-key "C-c 1" 'eyebrowse-switch-to-window-config-1 eyebrowse-mode-map)
    (bind-key "C-c 2" 'eyebrowse-switch-to-window-config-2 eyebrowse-mode-map)
    (bind-key "C-c 3" 'eyebrowse-switch-to-window-config-3 eyebrowse-mode-map)
    (bind-key "C-c 4" 'eyebrowse-switch-to-window-config-4 eyebrowse-mode-map)
    (bind-key "C-c 5" 'eyebrowse-switch-to-window-config-5 eyebrowse-mode-map)
    (bind-key "C-c 6" 'eyebrowse-switch-to-window-config-6 eyebrowse-mode-map)
    (bind-key "C-c 7" 'eyebrowse-switch-to-window-config-7 eyebrowse-mode-map)
    (bind-key "C-c 8" 'eyebrowse-switch-to-window-config-8 eyebrowse-mode-map)
    (bind-key "C-c 9" 'eyebrowse-switch-to-window-config-9 eyebrowse-mode-map)
    (eyebrowse-mode 1)
    ))

(use-package counsel-projectile
  :defer t
  :after projectilex
  :init (counsel-projectile-on))

(use-package ibuffer-projectile         ; Group buffers by Projectile project
  :defer t
  :init (add-hook 'ibuffer-hook #'ibuffer-projectile-set-filter-groups)
  :config
  (setq ibuffer-projectile-prefix ""))

(use-package ag
  :defer t)

(use-package page-break-lines)

(use-package dashboard
  :config
  (setq
   dashboard-startup-banner nil
   dashboard-items '((recents  . 10)
		     (projects . 10)
		     (bookmarks . 10)
		     ;; (agenda . 10)
		     ))
  (dashboard-setup-startup-hook)
  

  )


(provide 'config-projects)
