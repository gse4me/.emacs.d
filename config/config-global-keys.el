;;(use-package-with-elpa)

;; Add your keys here, as such

;;(global-set-key (kbd "[SHORTCUT]") '[FUNCTION])

;; on Linux, make Control+wheel do increase/decrease font size
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-o") 'occur)



(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)

(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-z") 'zap-up-to-char)



(global-set-key [f1] 'toggle-truncate-lines)
(global-set-key [f2] 'visual-line-mode)
(global-set-key [f5] 'gse-revert-buffer)





(provide 'config-global-keys)
