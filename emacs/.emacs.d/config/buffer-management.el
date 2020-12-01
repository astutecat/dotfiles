(global-set-key (kbd "C-x C-b") 'ibuffer)
;; Ensure ibuffer opens with point at the current buffer's entry.
(defadvice ibuffer
    (around ibuffer-point-to-most-recent) ()
    "Open ibuffer with cursor pointed to most recent buffer name."
    (let ((recent-buffer-name (buffer-name)))
      ad-do-it
      (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

(set-default 'truncate-lines t)
(global-set-key "\C-c$" 'toggle-truncate-lines)


(defun cleanup-buffer ()
  (interactive)
  (whitespace-cleanup)
  (untabify (point-min) (point-max)))
(global-set-key (kbd "s-\\") 'cleanup-buffer)

(defun kill-with-linenum (beg end)
  (interactive "r")
  (save-excursion
    (goto-char end)
    (skip-chars-backward "\n \t")
    (setq end (point))
    (let* ((chunk (buffer-substring beg end))
           (chunk (concat
                   (format "╭──────── #%-d ─ %s ──\n│ "
                           (line-number-at-pos beg)
                           (or (buffer-file-name) (buffer-name))
                           )
                   (replace-regexp-in-string "\n" "\n│ " chunk)
                   (format "\n╰──────── #%-d ─" 
                           (line-number-at-pos end)))))
      (kill-new chunk)))
  (deactivate-mark))
(global-set-key (kbd "s-w") 'kill-with-linenum)

(defun copy-current-line-position-to-clipboard ()
  "Copy current line in file to clipboard as '</path/to/file>:<line-number>'."
  (interactive)
  (let ((path-with-line-number
         (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))
    (kill-new path-with-line-number)
    (message (concat path-with-line-number " copied to clipboard"))))

;; Set new window buffer to another available one rather than
;; the currently open one
(defun switch-to-next-window-in-split ()
  (set-window-buffer (next-window) (other-buffer)))

(advice-add 'split-window-below :before #'switch-to-next-window-in-split)
