(setq erlang-indent-level 4)

(add-hook 'erlang-mode-hook 'my-erlang-imenu-hook)

(defun my-erlang-imenu-hook ()
  (if (and window-system (fboundp 'imenu-add-to-menubar))
      (imenu-add-to-menubar "Functions")))
