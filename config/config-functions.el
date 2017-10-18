;; Add your custom functions here

(defcustom gse-clean-whitespace-on-save t
  "Cleanup whitespace from file before it's saved.
Will only occur if `gse-whitespace' is also enabled.
One works on certain modes where it's enabled"
  :type 'boolean
  :group 'gse)


(defun gse-cleanup-maybe ()
  "Invoke `whitespace-cleanup' if `gse-clean-whitespace-on-save' is not nil."
  (when gse-clean-whitespace-on-save
    (whitespace-cleanup)))


(defun gse-revert-buffer()
  "revert buffer without asking for confirmation"
  (interactive "" )
  (revert-buffer t t)
  )

(defun gse-p4-edit-if-necessary ()
  "Call p4 edit if a file is turned writable"
  (if (and buffer-file-name
	   (not buffer-read-only))      
      (p4-edit)
    )
  )

;;;###autoload
(defun gse-swiper-at-point (_arg)
  "Swiper with 'thing-at-point'."
  (interactive "P")
  (swiper (thing-at-point 'symbol)))





;; Generates a list of random color values using the
;; Golden Ratio method described here:
;;   http://martin.ankerl.com/2009/12/09/how-to-create-random-colors-programmatically/
;; The list will be length long. Example:
;;
;; (gen-col-list 3 0.5 0.65)
;; => ("#be79d2" "#79d2a4" "#d28a79")
;; https://github.com/mariusk/emacs-color

(require 'color)
(defun gen-col-list (length s v &optional hval)
  (cl-flet ( (random-float () (/ (random 10000000000) 10000000000.0))
	     (mod-float (f) (- f (ffloor f))) )
    (unless hval
      (setq hval (random-float)))
    (let ((golden-ratio-conjugate (/ (- (sqrt 5) 1) 2))
          (h hval)
          (current length)
          (ret-list '()))
      (while (> current 0)
        (setq ret-list
              (append ret-list 
                      (list (apply 'color-rgb-to-hex (color-hsl-to-rgb h s v)))))
        (setq h (mod-float (+ h golden-ratio-conjugate)))
        (setq current (- current 1)))
      ret-list)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Improved from http://ergoemacs.org/emacs/emacs_CSS_colors.html
;; * Avoid mixing up #abc and #abcabc regexps
;; * Make sure dark background have light foregrounds and vice versa
(defun gse-syntax-color-hex ()
  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
URL `https://github.com/mariusk/emacs-color'
Version 2016-08-09"
  (interactive)
  (font-lock-add-keywords
   nil
   '(
     ("#[ABCDEFabcdef[:digit:]]\\{6\\}"
      (0 (progn (let* ((bgstr (match-string-no-properties 0))
                       (fgstr (fg-from-bg bgstr)))
                  (put-text-property
                   (match-beginning 0)
                   (match-end 0)
                   'face (list :background bgstr :foreground fgstr))))))
     ("#[ABCDEFabcdef[:digit:]]\\{3\\}[^ABCDEFabcdef[:digit:]]"
      (0 (progn (let* (
                       (ms (match-string-no-properties 0))
                       (r (substring ms 1 2))
                       (g (substring ms 2 3))
                       (b (substring ms 3 4))
                       (bgstr (concat "#" r r g g b b))
                       (fgstr (fg-from-bg bgstr)))
                  (put-text-property
                   (match-beginning 0)
                   (- (match-end 0) 1)
                   'face (list :background bgstr :foreground fgstr)
                   )))))
     ))
  (font-lock-fontify-buffer))



(provide 'config-functions)
