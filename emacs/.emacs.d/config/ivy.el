(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path
        (append
         (split-string-and-unquote path ":")
         exec-path)))

(counsel-projectile-mode +1)
(ivy-mode +1)
(counsel-mode +1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(minibuffer-depth-indicate-mode t)

(global-set-key "\C-s" 'swiper)
(setq ivy-display-style 'fancy)

;;advise swiper to recenter on exit
(defun bjm-swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter)
  )
(advice-add 'swiper :after #'bjm-swiper-recenter)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
