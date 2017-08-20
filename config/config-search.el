;; * Builtins

(use-package isearch
  :ensure nil
  :commands (isearch-forward-symbol-at-point isearch-forward)
  :init
  (progn
    ;; Reveal content of subtrees during isearch, alse see reveal-mode
    (setq-default isearch-invisible 'open)
    (validate-setq isearch-allow-scroll t
                   lazy-highlight-initial-delay 0))

  :config
  (bind-keys
   :map isearch-mode-map
   ;; Allow deleting chars in the search string, use C-r to search backwards
   ([remap isearch-delete-char] . isearch-del-char)))

;; * Packages

(use-package anzu :ensure t :init (global-anzu-mode))
(use-package imenu-anywhere :ensure t :defer t)
(use-package link-hint :ensure t :defer t)
(use-package goto-last-change :ensure t :commands goto-last-change :defer t)
(use-package swiper
  :ensure t
  :defer t
  :config
  (advice-add 'swiper :after #'recenter-top-bottom))

(use-package avy
  :ensure t
  :config
  (progn
    (validate-setq
     avy-style 'at-full
     avy-background t
     avy-all-windows t
     avy-timeout-seconds 0.28)
    ;; Use C-' in isearch to bring up avy
    (avy-setup-default)))

;; * Commands

;;;###autoload
(defun -swiper-at-point (_arg)
  "Swiper with 'thing-at-point'."
  (interactive "P")
  (swiper (thing-at-point 'symbol)))

(provide 'config-search)
