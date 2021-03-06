
(use-package hydra )


(defhydra hydra-git-gutter (:body-pre (git-gutter-mode 1)
				      :hint nil)
  "
Git gutter:

  Move                Edit                Quit
------------------------------------------------------------------------------------------
  _j_: next hunk        _s_tage hunk          _q_uit
  _k_: previous hunk    _r_evert hunk         _Q_uit and deactivate git-gutter
  ^ ^                   _p_opup hunk
  _h_: first hunk
  _l_: last hunk        set start _R_evision
"
  ("j" git-gutter:next-hunk)
  ("k" git-gutter:previous-hunk)
  ("h" (progn (goto-char (point-min))
              (git-gutter:next-hunk 1)))
  ("l" (progn (goto-char (point-min))
              (git-gutter:previous-hunk 1)))
  ("s" git-gutter:stage-hunk)
  ("r" git-gutter:revert-hunk)
  ("p" git-gutter:popup-hunk)
  ("R" git-gutter:set-start-revision)
  ("q" nil :color blue)
  ("Q" (progn (git-gutter-mode -1)
              ;; git-gutter-fringe doesn't seem to
              ;; clear the markup right away
              (sit-for 0.1)
              (git-gutter:clear))
   :color blue))

(defhydra hydra-eyebrowse (:hint nil)
  "
Workspace^                     ^Navigation^
------------------------------------------------
Workspace _1_   Workspace _6_   _n_ext workspace
Workspace _2_   Workspace _7_   _p_rev workspace
Workspace _3_   Workspace _8_   _l_ast workspace
Workspace _4_   Workspace _9_   _c_lose workspace
Workspace _5_   Workspace _0_   _q_uit
"
  ("1" eyebrowse-switch-to-window-config-1)
  ("2" eyebrowse-switch-to-window-config-2)
  ("3" eyebrowse-switch-to-window-config-3)
  ("4" eyebrowse-switch-to-window-config-4)
  ("5" eyebrowse-switch-to-window-config-5)
  ("6" eyebrowse-switch-to-window-config-6)
  ("7" eyebrowse-switch-to-window-config-7)
  ("8" eyebrowse-switch-to-window-config-8)
  ("9" eyebrowse-switch-to-window-config-9)
  ("0" eyebrowse-switch-to-window-config-0)
  ("n" eyebrowse-next-window-config)
  ("p" eyebrowse-prev-window-config)
  ("l" eyebrowse-last-window-config)
  ("c" eyebrows-close-window-config)
  ("q" nil :color blue)  
  )


(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("d"  projectile-find-dir-other-window         "dir")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color teal
				   :hint nil)
  "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
 _ff_: file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _fw_: file dwim       _g_: update gtags      _b_: switch to buffer  _x_: remove known project
 _fd_: file curr dir   _o_: multi-occur       _k_: kill all buffers  _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir             _s_: switch-project    

"
  ("a"   projectile-ag)
  ("b"   projectile-switch-to-buffer)
  ("c"   projectile-invalidate-cache)
  ("d"   projectile-find-dir)
  ("ff"  projectile-find-file)
  ("fw"  projectile-find-file-dwim)
  ("fd"  projectile-find-file-in-directory)
  ("g"   ggtags-update-tags)
  ("i"   projectile-ibuffer)
  ("k"   projectile-kill-buffers)  
  ("o"   projectile-multi-occur)  
  ("s"   projectile-switch-project)
  ("r"   projectile-recentf)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("`"   hydra-projectile-other-window/body "other window")
  ("w"   hydra-git-gutter/body "Gutter")
  ("q"   nil "cancel" :color blue))







(provide 'config-hydras)
