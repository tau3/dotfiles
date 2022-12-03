;; TODO comment lines
(setq inhibit-startup-screen t)
(menu-bar-mode 0)
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
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(doom-themes use-package which-key-posframe markdown-mode xresources-theme magit git-gutter smex markdown-mode which-key-mode)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
					
(global-set-key (kbd "M-x") 'smex)
(global-git-gutter-mode +1)
(setq vc-follow-symlinks t)

;; Turn on horizontal scrolling with mouse wheel
(global-set-key (kbd "<mouse-4>") 'scroll-down-line)
(global-set-key (kbd "<mouse-5>") 'scroll-up-line)
(setq mouse-wheel-scroll-amount '(1))
(setq mouse-wheel-progressive-speed nil)

(which-key-mode 1)

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  (doom-themes-treemacs-config)
  (doom-themes-org-config))

(global-set-key "\C-z" 'undo)

