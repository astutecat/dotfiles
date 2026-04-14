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
(setq modus-themes-italic-constructs t
      modus-themes-bold-constructs t
      modus-themes-mixed-fonts t
      ;modus-themes-variable-pitch-ui nil
      modus-themes-disable-other-themes t)

(load-theme 'modus-vivendi-tritanopia)

;; UI Tweaks
(menu-bar-mode -1)
(mouse-wheel-mode 1)

;; Doom Modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; Rainbow Delimeters
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

;; Vertico
(use-package vertigo
  :ensure t
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

;; Save History
(use-package savehist
  :init
  (savehist-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package nerd-icons-completion
  :after marginalia
  :config
  (nerd-icons-completion-mode)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package affe
  :config
  ;; Manual preview key for `affe-grep'
  (consult-customize affe-grep :preview-key "M-."))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-pcm-leading-wildcard t))

(defun affe-orderless-regexp-compiler (input _type _ignorecase)
  (setq input (cdr (orderless-compile input)))
  (cons input (apply-partially #'orderless--highlight input t)))
(setq affe-regexp-compiler #'affe-orderless-regexp-compiler)
