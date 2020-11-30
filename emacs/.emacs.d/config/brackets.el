(electric-pair-mode +1)
(setq blink-matching-paren-distance 102400)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)
(add-hook 'text-mode-hook (highlight-parentheses-mode -1))
