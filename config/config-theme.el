;;(use-package-with-elpa)

(use-package zenburn-theme
  :defer t
  )

(use-package solarized-theme
  :defer t
  )

(use-package dracula-theme
  :defer t
  :config
  (custom-theme-set-faces
   'dracula
   `(company-tooltip
     ((t :inherit default :background "#403D3D")))
   `(company-scrollbar-bg ((t :background "#232526")))
   `(company-scrollbar-fg ((t :background "#E6DB74")))
   `(company-tooltip-selection ((t :inherit font-lock-function-name-face)))
   `(company-tooltip-common ((t :inherit font-lock-constant-face))))
  )


(use-package doom-themes
  :defer t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t ; if nil, italics is universally disabled
	;;doom-one-brighter-modeline

	)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme
  (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config)
  )


(load-theme 'dracula t)
(provide 'config-theme)
