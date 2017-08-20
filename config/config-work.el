






;;<USER CFG>
;;comment below to scroll faster in large files (.c/.cc/.cpp)
;;the file will load slower because more of it will be fontified
;;with this commented the load is faster but scroll is weak
					;(setq jit-lock-chunk-size 50000)


(add-to-list 'auto-mode-alist '("\\.xml\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\env.cfg\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.wacfg\\'" . xml-mode))
(add-to-list 'auto-mode-alist '("modulefile\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.modulefile\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("setup.proj\\'" . sh-mode))
(add-to-list 'auto-mode-alist '("\\.dj\\'" . ruby-mode))



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
        ("P0000" . font-lock-warning-face)
	("P0001" . font-lock-string-face)
        ("P0010*" . font-lock-function-name-face)
	("P0011"  . font-lock-comment-face)
        ("Ex:.*" . font-lock-warning-face)
	("Bridge Code:" . font-lock-type-face)
    	("Excp.*" . font-lock-constant-face)
 	("Mr:" . font-lock-keyword-face)
 	("Mw:" . font-lock-function-name-face)
      	)
      )

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

(define-derived-mode gse-kos-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords_kos))
  (setq mode-name "gse-kos-mode")
  )

(define-derived-mode gse-dsp-mode fundamental-mode
  (setq font-lock-defaults '(myKeywords_dsp))
  (setq mode-name "gse-dsp-mode")
  )

(add-to-list 'auto-mode-alist '("\\.koslog" . gse-kos-mode))
(add-to-list 'auto-mode-alist '("\\.klog" . gse-kos-mode))
(add-to-list 'auto-mode-alist '("\\.kos" . gse-kos-mode))
(add-to-list 'auto-mode-alist '("*dsp*\\.txt" . gse-dsp-mode))

(provide 'config-work)
