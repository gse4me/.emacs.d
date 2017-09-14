
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
  :defer t
  :init
  (setq
   smex-history-length 20
   smex-save-file (expand-file-name  "smex-items" my-savefile-dir)
   )
  )


(defun eh-ivy-open-current-typed-path ()
  (interactive)
  (when ivy--directory
    (let* ((dir ivy--directory)
           (text-typed ivy-text)
           (path (concat dir text-typed)))
      (delete-minibuffer-contents)
      (ivy--done path))))


(use-package ivy
  :init
  (ivy-mode 1)
  :diminish ivy-mode
  :bind(
	("C-x s" . swiper)
	("C-x C-r" . ivy-resume)
	:map ivy-minibuffer-map
	("<return>" . ivy-alt-done)
	("C-f" . eh-ivy-open-current-typed-path))
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
	ivy-rich-switch-buffer-align-virtual-buffer nil
	ivy-rich-abbreviate-paths t
	ivy-rich-switch-buffer-project-max-length 75
	ivy-rich-switch-buffer-name-max-length 80
	ivy-rich-switch-buffer-delimiter "|")
  )

(provide 'config-ivy)
