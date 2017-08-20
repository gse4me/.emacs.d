(use-package-with-elpa)


(use-package auto-compile
  :config
  (progn
    (auto-compile-on-load-mode)
    (auto-compile-on-save-mode)
    )
  )


(use-package spinner )
(use-package async )

(use-package paradox
  :commands (paradox-upgrade-packages paradox-list-packages)
  :config
  (progn
    (setq paradox-execute-asynchronously t
          paradox-github-token t)
    (paradox-enable)
    )
  )



(provide 'config-package-extra)
