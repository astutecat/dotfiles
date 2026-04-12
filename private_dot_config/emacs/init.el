;; Set up a separate file to save customizations.
(setq custom-file "~/.config/emacs/custom.el")
(load custom-file)

;; On exit, prompt if there are unsaved customizations.
(add-hook 'kill-emacs-query-functions
          'custom-prompt-customize-unsaved-options)


;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(package-install-selected-packages)

;; Enable Evil
(require 'evil)
(evil-mode 0)

;; Theme
(require 'modus-themes)
(setq modus-themes-disable-other-themes t)
(load-theme 'modus-vivendi-tritanopia)

;; UI Tweaks
(menu-bar-mode -1)

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Rainbow Delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
