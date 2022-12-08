(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(ido-mode 1)
(xterm-mouse-mode 1)
(global-display-line-numbers-mode 1)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(rust-mode dashboard tron-legacy-theme reverse-im flycheck company lsp-treemacs all-the-icons lsp-ui lsp-mode use-package markdown-mode magit git-gutter smex markdown-mode which-key-mode)))
			
(global-set-key (kbd "M-x") 'smex)
(global-git-gutter-mode +1)
(setq vc-follow-symlinks t)

;; Turn on horizontal scrolling with mouse wheel
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

(which-key-mode 1)

(use-package tron-legacy-theme
  :config
  (setq tron-legacy-theme-vivid-cursor t)
  ;; (setq tron-legacy-theme-softer-bg t)
  (load-theme 'tron-legacy t))

(global-set-key "\C-z" 'undo)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key "\M-." 'end-of-buffer)
(global-set-key "\M-," 'beginning-of-buffer)
(global-set-key "\M-[" 'backward-paragraph)
(global-set-key "\M-]" 'forward-paragraph)

(lsp-treemacs-sync-mode 1)

;; make hotkeys work on russian keyboard
(use-package reverse-im
  :ensure t
  :custom
  (reverse-im-input-methods '("russian-computer"))
  :config
  (reverse-im-mode t))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

;; Preserve the cursor position relative to the screen when scrolling
(setq scroll-preserve-screen-position 'always)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

