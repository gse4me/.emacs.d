
(use-package treemacs
  :ensure t
  :defer t
  :config
  (progn
    ;; (use-package treemacs-evil
    ;;   :ensure t
    ;;   :demand t)
    (setq treemacs-follow-after-init          t
          treemacs-width                      35
          treemacs-indentation                2
          treemacs-git-integration            t
          treemacs-silent-refresh             nil
          treemacs-change-root-without-asking nil
          treemacs-sorting                    'alphabetic-desc
          treemacs-show-hidden-files          t
          treemacs-never-persist              nil
          treemacs-goto-tag-strategy          'refetch-index)

    (treemacs-follow-mode t)
    (treemacs-filewatch-mode t)
    )
  :bind
  (:map global-map
	([f8]        . treemacs-toggle)
	("<C-M-tab>" . treemacs-toggle)
	("M-0"       . treemacs-select-window)
	("C-c 1"     . treemacs-delete-other-windows)
	)
  )

(use-package treemacs-projectile
  :ensure t
  :config
  (setq treemacs-header-function #'treemacs-projectile-create-header)
  :bind
  (:map global-map
	([f9]        . treemacs-projectile)
	([f10] . treemacs-projectile-toggle)
	)
  )

;; (use-package neotree
;;   :config
;;   (setq neo-theme 'arrow ; 'classic, 'nerd, 'ascii, 'arrow ;;
;;         neotree-smart-open t
;; 	projectile-switch-project-action 'neotree-projectile-action
;; 	neo-window-width 60
;;         neo-window-fixed-size nil
;; 	neo-show-updir-line t
;; 	neo-force-change-root t
;; 	)

;;   :bind
;;   (:map global-map
;;     	([f9]        . neotree-toggle))

;;   ;; Disable linum for neotree			      ;;
;; 					;(add-hook 'neo-after-create-hook 'disable-neotree-hook) ;;
;;   )


(provide 'config-tree)
