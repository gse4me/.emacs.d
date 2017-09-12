;;(use-package-with-elpa)

;; * Builtins

(use-package isearch
  :no-require t
  :ensure nil
  :commands (isearch-forward-symbol-at-point isearch-forward)
  :init
  (progn
    ;; Reveal content of subtrees during isearch, alse see reveal-mode
    (set-face-foreground 'isearch "red")
    (set-face-background 'isearch "green")

    (set-face-foreground 'lazy-highlight "black")
    (set-face-background 'lazy-highlight "white")
    (custom-set-faces '(isearch-fail ((((class color)) (:background "red")))))


    (setq-default isearch-invisible 'open)
    (setq isearch-allow-scroll t
	  lazy-highlight-initial-delay 0))

  :config
  (bind-keys
   :map isearch-mode-map
   ;; Allow deleting chars in the search string, use C-r to search backwards
   ([remap isearch-delete-char] . isearch-del-char)))

;; * Packages

(use-package anzu
  :init (global-anzu-mode)
  :diminish anzu-mode
  )
(use-package imenu-anywhere
  :defer t
  )
(use-package link-hint
  :defer t
  )
(use-package goto-last-change
  :commands goto-last-change
  :defer t
  )

(use-package swiper
  :defer t
  :config
  (advice-add 'swiper :after #'recenter-top-bottom))

;; (use-package avy
;;   :config
;;   (progn
;;     (setq
;;      avy-style 'at-full
;;      avy-background t
;;      avy-all-windows t
;;      avy-timeout-seconds 0.28)
;;     ;; Use C-' in isearch to bring up avy
;;     (avy-setup-default)))

;; * Commands

;;;###autoload
(defun -swiper-at-point (_arg)
  "Swiper with 'thing-at-point'."
  (interactive "P")
  (swiper (thing-at-point 'symbol)))

(provide 'config-search)
