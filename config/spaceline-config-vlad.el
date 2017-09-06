(require 'spaceline-segments)

;; (defun hsl (H S L) ; convenience fn
;;   (apply 'color-rgb-to-hex (color-hsl-to-rgb (/ H 360.0) S L)))
;; (defun face (face &rest spec) ; convenience fn
;;   (face-spec-set face (list (cons t spec))))

;; (face 'vlad/spaceline-read-only :background (hsl 300 0.15 0.5) :foreground "gray80" :box `(:line-width -2 :color ,(hsl 300 0.4 0.5)))
;; (face 'vlad/spaceline-modified :background "GoldenRod2" :foreground "black")


(spaceline-define-segment current-company-backend
  (when (bound-and-true-p company-candidates)
    (if (consp company-backend)
	(company--group-lighter (nth company-selection
				     company-candidates)
				company-lighter-base)
      (symbol-name company-backend))))


   (spaceline-define-segment vlad/line-column
     "The current line and column numbers, or `(current page/number of pages)`
in pdf-view mode (enabled by the `pdf-tools' package)."
     (if (eq major-mode 'pdf-view-mode)
	 (spaceline--pdfview-page-number)
       "<L:%l C:%2c>"))

   (spaceline-define-segment vlad/buffer-modified
     "Buffer status (read-only, modified), with color"
     (cond (buffer-read-only (propertize "RO" ))
	   ((buffer-modified-p) (propertize "MO" ))
	   (t "  ")))

   (defun spaceline--theme (left second-left &rest additional-segments)
     "Convenience function for the spacemacs and emacs themes."
     (spaceline-install
       `(,left
	 ;;(anzu :priority 4)
	 auto-compile
	 ,second-left
	 (
	  (
	   point-position
	   vlad/line-column
	   (buffer-size :priority 5)
	   (buffer-position :priority 0)
	   (hud :priority 0)
	   )
	  )

	 (process :when active)
	 (
	  (flycheck-error flycheck-warning flycheck-info)
	  :when active
	  :priority 3
	  )
	 (minor-modes :when active)
	 (mu4e-alert-segment :when active)
	 (erc-track :when active)
	 (version-control :when active
			  :priority 7)
	 (org-pomodoro :when active)
	 (org-clock :when active)
	 nyan-cat
	 which-function
	 (python-pyvenv :fallback python-pyenv)
	 purpose
	 current-company-backend
	 (battery :when active)
	 (selection-info :priority 2)
	 input-method
	 (global :when active)
	 ,@additional-segments
	 )
       `()
       )

     (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))))

(defun spaceline-spacemacs-theme (&rest additional-segments)
  "Install the modeline used by Spacemacs.

ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'."
  (apply 'spaceline--theme
         '((evil-state
	    persp-name
            workspace-number
	    window-number
	    vlad/buffer-modified
	    major-mode)
           :fallback evil-state
           :face highlight-face
           :priority 0)
         '((buffer-id remote-host)
           :priority 5)
         additional-segments))

(defun spaceline-emacs-theme (&rest additional-segments)
  "Install a modeline close to the one used by Spacemacs, but which
looks better without third-party dependencies.

ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'."
  (apply 'spaceline--theme
         '(((((persp-name :fallback workspace-number)
              window-number) :separator "|")
            buffer-modified
            buffer-size)
           :face highlight-face
           :priority 0)
         '((buffer-id remote-host)
           :priority 5)
         additional-segments))

;; Helm custom mode
;; ================

(defvar helm-ag-show-status-function)

(defun spaceline--helm-ag-update ()
  (setq mode-line-format '("%e" (:eval (spaceline-ml-helm-done)))))

(define-minor-mode spaceline-helm-mode
  "Customize the mode-line in helm."
  :init-value nil
  :global t
  (if spaceline-helm-mode
      (progn
	(spaceline-install 'helm
	  '((helm-buffer-id :face highlight-face)
	    helm-number
	    helm-follow
	    helm-prefix-argument)
	  '(helm-help))

	(spaceline-install 'helm-done
	  '(((helm-buffer-id helm-done) :face highlight-face)
	    helm-number
	    helm-follow
	    helm-prefix-argument)
	  '(helm-help))
	(defadvice helm-display-mode-line (after spaceline-helm)
	  "Set up a custom helm modeline."
	  (setq spaceline--helm-current-source source
		mode-line-format '("%e" (:eval (spaceline-ml-helm))))
	  (when force (force-mode-line-update)))
	(setq helm-ag-show-status-function 'spaceline--helm-ag-update)
	(ad-activate 'helm-display-mode-line))
    (setq helm-ag-show-status-function 'helm-ag-show-status-default-mode-line)
    (ad-deactivate 'helm-display-mode-line)))

;; Info custom mode
;; ================

(define-minor-mode spaceline-info-mode
  "Customize the mode-line in info.
This minor mode requires info+."
  :init-value nil
  :global t
  (if spaceline-info-mode
      (progn
	(spaceline-install 'info '(info-topic (info-nodes :separator " > ")) nil)
	(defadvice Info-set-mode-line (after spaceline-info)
	  "Set up a custom info modeline."
	  (if (featurep 'info+)
	      (let* ((nodes (s-split " > " mode-line-format))
		     (topic (prog2
				(string-match "(\\(.+\\))\\(.+\\)" (car nodes))
				(propertize (concat "INFO "
						    (match-string 1 (car nodes)))
					    'face 'bold)
			      (setcar nodes (match-string 2 (car nodes))))))
		(setq spaceline--info-nodes nodes)
		(setq spaceline--info-topic topic)
		(setq-local mode-line-format '("%e" (:eval (spaceline-ml-info)))))
	    (message "info+ is not available: spaceline-info-mode disabled")
	    (spaceline-info-mode -1)))
	(ad-activate 'Info-set-mode-line))
    (ad-deactivate 'Info-set-mode-line)))

(provide 'spaceline-config-vlad)
