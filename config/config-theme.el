(use-package-with-elpa)


(use-package dracula-theme
  :defer t
  :init
  (load-theme 'dracula t))




(custom-theme-set-faces
 'dracula

 ;; Additional modes
 ;; Company tweaks.
 `(company-tooltip
   ((t :inherit default
       :background "#403D3D")))

 `(company-scrollbar-bg
   ((t :background "#232526")))

 `(company-scrollbar-fg
   ((t :background "#E6DB74")))

 `(company-tooltip-selection
   ((t :inherit font-lock-function-name-face)))

 `(company-tooltip-common
   ((t :inherit font-lock-constant-face))))




(provide 'config-theme)
