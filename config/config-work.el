;;;;;; perforceee ;;;;;;;

(use-package p4  
  :init
  (setq p4-executable my-p4-ex)
  (setq p4-global-key-prefix (kbd "C-x p"))
  :config
  ;;(setq p4-do-find-file nil )
  (add-hook 'p4-mode-hook
	    (lambda () (add-hook 'read-only-mode-hook 'gse-p4-edit-if-necessary nil t)))
  
  )




;;;;;;;;;;;;;;;;;;;;;;;;;;;; Default modes for various extensions ;;;;;;;;;

(add-to-list 'auto-mode-alist '("\\.xml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\env.cfg\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.wacfg\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("modulefile\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.modulefile\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("setup.proj\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.dj\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\Makefile'" . sh-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;coloring for df logs;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq myKeywords_df
      '(
       	("SDP_ID[^ ]*" . font-lock-type-face)
       	("SDP_CMD[^ ]*" . font-lock-type-face)
	("CHTP_CMD[^ ]*" . font-lock-type-face)
        ("F_T:" .  font-lock-type-face)
	("uvm_test_top[^ ]*" . font-lock-constant-face)
	("UVM_WARNING" . font-lock-function-name-face)
 	("UVM_INFO"  . font-lock-comment-face)
        ("UVM_ERROR" . font-lock-warning-face)
        ("From[^ ]*" . font-lock-function-name-face)
	("To[^ ]*" . font-lock-function-name-face)
	("CCM_ID[^ ]*" . font-lock-warning-face)
	("0x[^ ]*" . font-lock-warning-face)
        ("/proj/[^ ]*" . font-lock-warning-face)
	("'h[^ ]*" . font-lock-string-face)
	("'b[^ ]*" . font-lock-string-face)
	("'d[^ ]*" . font-lock-string-face)
        ("{" . font-lock-warning-face)
	("}" . font-lock-warning-face)
	("(" . font-lock-type-face)
       	(")" . font-lock-type-face)
	("\\[" . font-lock-constant-face)
       	("\\]" . font-lock-constant-face)
	)
      )

(define-derived-mode gse-df-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords_df))
  (setq mode-name "gse-df-mode")
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;coloring for core logs;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq myKeywords_kos
      '(
	;; ("P0000" . font-lock-warning-face)
	;; ("P0001" . font-lock-string-face)
	;; ("P0010*" . font-lock-function-name-face)
	;; ("P0011"  . font-lock-comment-face)
        ("Ex:.*" . font-lock-warning-face)
	("Bridge Code:" . font-lock-type-face)
    	("Excp.*" . font-lock-constant-face)
 	("Mr:" . font-lock-keyword-face)
 	("Mw:" . font-lock-function-name-face)
	("Tw:" . font-lock-warning-face)
	(" [^= ]+=" . font-lock-string-face)
      	)
      )

(defgroup gse-core-faces nil
  "KOS core faces" 
  :group 'faces
  :link '(custom-group-link "gse-core-faces")
  :prefix "gse-rainbow-delimiters-")


(eval-when-compile
  (defmacro gse-kos-define-core-faces()
    (let ((faces '())
	  (colors (gen-col-list 256 0.8 0.7 0.9))
	  (itr 1))
      (dotimes (bit3 4)
	(dotimes (bit2 4)
	  (dotimes (bit1 4)
	    (dotimes (bit0 4) 
	      (let (
		    (core-name (concat "P" (number-to-string bit3) (number-to-string bit2) (number-to-string bit1) (number-to-string bit0))))
		(let ((gse-var-name (concat "gse-kos-core-" core-name "-face"))
		      (col (nth itr colors)))	      
		  ;;(message core-name)
		  ;;(message gse-var-name)
		  (push `(defface ,(intern (format "%s" gse-var-name)) 
			   '((((class color) (background light)) :foreground ,(nth itr colors))
			     (((class color) (background dark)) :foreground ,(nth itr colors)))
			   ,(format "Core face for %s." core-name)
			   :group 'gse-core-faces)
			faces)

		  (add-to-list 'myKeywords_kos `( ,(concat  core-name  ) . ',(intern gse-var-name)))
		  ))
	      (setq itr (1+ itr))
	      )
	    )
	  )
	)
      `(progn ,@faces)
      )
    ))

(gse-kos-define-core-faces)

(define-derived-mode gse-kos-mode fundamental-mode
  (gse-kos-define-core-faces)
  (setq font-lock-defaults '(myKeywords_kos))
  (setq mode-name "gse-kos-mode") 
  )

(add-to-list 'auto-mode-alist '("\\.koslog$" . gse-kos-mode))
(add-to-list 'auto-mode-alist '("\\.klog$" . gse-kos-mode))
(add-to-list 'auto-mode-alist '("\\.kos$" . gse-kos-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; DSP log is not used anymore;;;;;;;;;;;;;;;;;;;;;

(setq myKeywords_dsp
      '(
	("^[0-9]*\s" . font-lock-preprocessor-face)
	("S[0-9]+\s" . font-lock-string-face)
	("sys[^ ]*\s" . font-lock-function-name-face)
	("mpu[^ ]*\s" . font-lock-function-name-face)
	("\s0x[0-9a-fA-F]*\\+" . font-lock-warning-face)
	("0x..\s"  . font-lock-comment-delimiter-face)
	("0x[0-9a-fA-F_]+" . font-lock-type-face)
	("[S|s]tate=[M|O|E|S|F|I]\s" . font-lock-constant-face)
	("ThreadId=[^ ]" . font-lock-keyword-face)
	("Command=[^ ]*" . font-lock-function-name-face)
	)
      )



(define-derived-mode gse-dsp-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords_dsp))
  (setq mode-name "gse-dsp-mode")
  )
;;(add-to-list 'auto-mode-alist '("*dsp*\\.txt" . gse-dsp-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(provide 'config-work)
