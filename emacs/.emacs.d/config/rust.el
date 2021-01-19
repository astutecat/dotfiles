(with-eval-after-load 'company (add-to-list 'company-backends 'company-racer))

(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(setq company-tooltip-align-annotations t)
(setq racer-rust-src-path
  "/Users/astutecat/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/library")
