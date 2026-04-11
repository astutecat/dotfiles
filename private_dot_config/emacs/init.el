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
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)
