(defvar initial-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'lisp-interaction-mode)
    map)
  "Keymap for `initial-mode'.")
(define-derived-mode initial-mode nil "Initial"
  "Major mode for start up buffer.
\\{initial-mode-map}"
  (setq-local text-mode-variant t)
  (setq-local indent-line-function 'indent-relative))

(setq  initial-major-mode 'initial-mode
initial-scratch-message "\
;; Scratch buffer. Use C-c C-c to enter lisp-interation-mode.
;; ---------------------------------------------------------

")
