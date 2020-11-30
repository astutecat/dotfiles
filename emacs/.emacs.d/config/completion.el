(company-mode +1)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'text-mode-hook (company-mode -1))
