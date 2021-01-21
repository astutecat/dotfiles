(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(blink-cursor-mode nil)
 '(custom-safe-themes
   '("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "d4f8fcc20d4b44bf5796196dbeabec42078c2ddb16dcb6ec145a1c610e0842f3" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "7451f243a18b4b37cabfec57facc01bd1fe28b00e101e488c61e1eed913d9db9" default))
 '(display-time-mode t)
 '(electric-pair-mode t)
 '(global-display-line-numbers-mode t)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(indicate-empty-lines t)
 '(package-selected-packages
   '(company-racer rustic racer magit gitignore-mode initsplit auctex markdown-mode highlight-parentheses smart-mode-line undo-tree ggtags ag ibuffer-vc company-erlang company counsel-projectile ivy fzf projectile dracula-theme))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(size-indication-mode t)
 '(tool-bar-mode nil))

(delete-selection-mode 1)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Fira Code" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
(package-install-selected-packages)
(load-theme 'dracula t)
(sml/setup)

(defun load-directory (directory)
  "Load recursively all `.el' files in DIRECTORY."
  (dolist (element (directory-files-and-attributes directory nil nil nil))
    (let* ((path (car element))
           (fullpath (concat directory "/" path))
           (isdir (car (cdr element)))
           (ignore-dir (or (string= path ".") (string= path ".."))))
      (cond
       ((and (eq isdir t) (not ignore-dir))
        (load-directory fullpath))
       ((and (eq isdir nil) (string= (substring path -3) ".el"))
        (load (file-name-sans-extension fullpath)))))))

(setq-default indent-tabs-mode nil)

(require 'hi-lock)
(defun jpt-toggle-mark-word-at-point ()
  (interactive)
  (if hi-lock-interactive-patterns
      (unhighlight-regexp (car (car hi-lock-interactive-patterns)))
    (highlight-symbol-at-point)))
(global-set-key (kbd "s-.") 'jpt-toggle-mark-word-at-point)

(setq large-file-warning-threshold 85000000)
                                        ; tramp settings
(require 'tramp)
(setq tramp-default-method "scp")

(display-time)
(setq display-time-24hr-format t)
;;(setq display-time-day-and-date t)

(global-set-key (kbd "C-x SPC") 'cua-rectangle-mark-mode)
(setq use-dialog-box nil)

(load-directory (concat user-emacs-directory "config"))

(let ((local-settings (concat user-emacs-directory "init-local.el")))
  (when (file-exists-p local-settings)
    (load-file local-settings)))
