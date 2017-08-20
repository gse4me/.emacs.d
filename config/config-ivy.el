
(use-package flx :ensure t )

(use-package swiper :ensure t :defer t)

(use-package uniquify
  :ensure nil
  :config
  (setq-default uniquify-buffer-name-style 'forward))

(use-package counsel
  :ensure t
  :config
  (progn
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  ;  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  ;  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  ;  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  ;  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  ;  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    )
  )


(use-package ivy
  :ensure try
  :bind
  ("C-x s" . swiper)
  ("C-x C-r" . ivy-resume)
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    (setq ivy-re-builders-alist
          '((read-file-name-internal . ivy--regex-fuzzy)
            (counsel-M-x . ivy--regex-fuzzy)
            (t . ivy--regex-plus)))
    (setq ivy-initial-inputs-alist nil)
    (setq ivy-extra-directories nil)
    )
  )
                                        ;(setq ivy-initial-inputs-alist nil) use above so no ^ will be used when starting

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; !!! also uses the (setq ivy-extra-directories nil) from above
;; Instead of opening a fodler in buffer mode, just go into it and create new candidates for completion														     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun eh-ivy-open-current-typed-path ()
  (interactive)
  (when ivy--directory
    (let* ((dir ivy--directory)
           (text-typed ivy-text)
           (path (concat dir text-typed)))
      (delete-minibuffer-contents)
      (ivy--done path))))

(define-key ivy-minibuffer-map (kbd "<return>") 'ivy-alt-done)
(define-key ivy-minibuffer-map (kbd "C-f") 'eh-ivy-open-current-typed-path)




(provide 'config-ivy)
