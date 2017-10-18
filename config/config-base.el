;; Core settings
;; UTF-8 please
(set-charset-priority 'unicode)
(setq locale-coding-system   'utf-8)   ; pretty
(set-terminal-coding-system  'utf-8)   ; pretty
(set-keyboard-coding-system  'utf-8)   ; pretty
(set-selection-coding-system 'utf-8)   ; please
(prefer-coding-system        'utf-8)   ; with sugar on top
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;;ibuffer format to se more 
(setq ibuffer-formats
      '((mark modified read-only " "
              (name 30 30 :left :elide) " "
              (size 12 -1 :right) " "
              (mode 16 16 :left :elide) " " filename-and-process)
        (mark " " (name 16 -1) " " filename)))

;; Some better general defaults
(setq
 ;;confirm-kill-emacs                  'y-or-n-p
 global-hl-line-mode                 t
 truncate-lines                      t
 visual-line-mode                    t
 apropos-do-all                      t
 load-prefer-newer                   t
 frame-title-format                  "%b %+%+ %f"
 confirm-nonexistent-file-or-buffer  t
 save-interprogram-paste-before-kill t
 ;;mouse-yank-at-point                 t
 require-final-newline               t
 visible-bell                        nil
 ring-bell-function                  'ignore
 custom-file                         "~/.emacs.d/.custom.el"
 ;; http://ergoemacs.org/emacs/emacs_stop_cursor_enter_prompt.html
 minibuffer-prompt-properties
 '(read-only t point-entered minibuffer-avoid-prompt face minibuffer-prompt)

 ;; Disable non selected window highlight
 cursor-in-non-selected-windows     nil
 highlight-nonselected-windows      nil
 ;; PATH
 exec-path                          (append exec-path '("/usr/local/bin/"))
 indent-tabs-mode                   nil
 inhibit-startup-message            t
 fringes-outside-margins            t
 select-enable-clipboard            t
 switch-to-buffer-preserve-window-point t
 jit-lock-chunk-size                    5000  ;; how much to fontify
 enable-recursive-minibuffers       t 
 )


;; Backups , use nil to disable
(setq
 history-length                     1000
 backup-inhibited                   nil
 make-backup-files                  nil
 auto-save-default                  nil
 make-backup-files                  nil
 create-lockfiles                   nil
 )

(fset 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode t)


;; Disable toolbar & menuba
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))

(show-paren-mode 1)
(global-hl-line-mode 1)
;;(which-function-mode 1)

;; Delete trailing whitespace before save
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;; cperl-mode is preferred to perl-mode
(defalias 'perl-mode 'cperl-mode)


;; configure isearch
(set-face-foreground 'isearch "red")
(set-face-background 'isearch "green")
(set-face-foreground 'lazy-highlight "black")
(set-face-background 'lazy-highlight "white")
(custom-set-faces '(isearch-fail ((((class color)) (:background "red")))))

(setq-default isearch-invisible 'open)
(setq isearch-allow-scroll t
      lazy-highlight-initial-delay 0)

(define-key isearch-mode-map (kbd "DEL") 'isearch-del-char)


(provide 'config-base)
;;; base ends here
