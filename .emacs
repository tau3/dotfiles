
;;; Code:
(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dumb-jump-window (quote other))
 '(haskell-interactive-popup-errors nil)
 '(haskell-mode-hook
   (quote
    (interactive-haskell-mode
     (lambda nil
       (local-set-key
	(kbd "<f2>")
	(quote flycheck-next-error))
       (local-set-key
	(kbd "C-<f2>")
	(quote flycheck-previous-error)))
     company-mode flycheck-haskell-setup hindent-mode)))
 '(hindent-reformat-buffer-on-save t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (exec-path-from-shell dumb-jump company-ghci apt-sources-list yaml-mode flycheck-haskell hindent smex haskell-mode))))

(package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install-selected-packages)

;; haskell-mode stuff
(exec-path-from-shell-initialize)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'haskell-mode-hook #'hindent-mode)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)
(add-hook 'haskell-mode-hook #'flycheck-haskell-setup)
(require 'company-ghci)
(push 'company-ghci company-backends)
(add-hook 'haskell-mode-hook 'company-mode)
(add-hook 'haskell-interactive-mode-hook 'company-mode)

(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-c <right>") 'forward-sentence)
(global-set-key (kbd "C-c <left>") 'backward-sentence)
(global-set-key (kbd "C-c b") 'dumb-jump-go)

(ido-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
(setq vc-follow-symlinks nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode))
(when (version< emacs-version "26.0.50" )
  (setq linum-format "%d ")
  (global-linum-mode))
(setq backup-directory-alist `(("." . "~/.saves")))
(setq inhibit-startup-screen t)

(show-paren-mode 1)
(setq show-paren-style 'mixed)

(provide '.emacs)
;;; .emacs ends here

