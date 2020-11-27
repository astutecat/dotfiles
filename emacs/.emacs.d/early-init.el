(when (eq system-type 'darwin)
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier nil))

(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 100))
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(foreground-color . "white"))

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))

;;disable splash screen and startup message
(setq inhibit-startup-message t)
