(use-package-with-elpa)

(use-package flx :defer t)
(use-package swiper :defer t)

(use-package uniquify
  :no-require t
  :ensure nil
  :config
  (setq-default uniquify-buffer-name-style 'forward))

(use-package counsel
  :bind
  ( "M-x" . counsel-M-x)
  ( "C-x C-f" . counsel-find-file)
  ( "C-c g". counsel-git)
  ( "C-c j" . counsel-git-grep)
  ( "C-c k" . counsel-ag)
  ( "C-x l" . counsel-locate)
  ( "C-S-o" . counsel-rhythmbox)
  ( "C-c C-r" . ivy-resume)
  )

;; Counsel makes use of smex
(use-package smex
  :init
  (setq smex-history-length 20)
  :defer t
  )


(defun eh-ivy-open-current-typed-path ()
  (interactive)
  (when ivy--directory
    (let* ((dir ivy--directory)
           (text-typed ivy-text)
           (path (concat dir text-typed)))
      (delete-minibuffer-contents)
      (ivy--done path))))

;; Use C-j for immediate termination with the current value, and RET
;; for continuing completion for that directory. This is the ido
;; behaviour.
;;(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
;;(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)


(use-package ivy
  :init
  (ivy-mode 1)
  :diminish ivy-mode
  :bind(
	("C-x s" . swiper)
	("C-x C-r" . ivy-resume)
	:map ivy-minibuffer-map
	("<return>" . ivy-alt-done)
	("C-f" . eh-ivy-open-current-typed-pat))
  :config
  (progn
    (setq ivy-use-virtual-buffers t
	  ivy-count-format "(%d/%d) "

	  ;; (setq ivy-re-builders-alist
	  ;; 	  '((read-file-name-internal . ivy--regex-fuzzy)
	  ;; 	    (counsel-M-x . ivy--regex-fuzzy)
	  ;; 	    (t . ivy--regex-plus)))

	  ivy-re-builders-alist
	  '((counsel-projectile-find-file . ivy--regex-plus)
	    (t . ivy--regex-fuzzy))
	  ivy-initial-inputs-alist nil
	  ivy-extra-directories nil)
    )
  )
;;(setq ivy-initial-inputs-alist nil) use above so no ^ will be used when starting

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; !!! also uses the (setq ivy-extra-directories nil) from above
;; Instead of opening a fodler in buffer mode, just go into it and create new candidates for completion														     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package ivy-rich ;; This may eventually be merged into Ivy Master
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
  (setq ivy-virtual-abbreviate 'full
	ivy-rich-switch-buffer-align-virtual-buffer t
	ivy-rich-abbreviate-paths t
	ivy-rich-switch-buffer-project-max-length 56
	ivy-rich-switch-buffer-name-max-length 88
	ivy-rich-switch-buffer-delimiter "|")
  )

(use-package ivy-historian              ; Store minibuffer candidates
  :after ivy
  :config (ivy-historian-mode t))

(provide 'config-ivy)
