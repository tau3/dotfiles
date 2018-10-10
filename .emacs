(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hindent-reformat-buffer-on-save t)
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
    (hindent flymake-haskell-multi exec-path-from-shell company-ghc smex haskell-mode auto-complete))))

;; haskell-mode stuff
(package-initialize)
(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(require 'haskell-mode)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))
(require 'hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(ido-mode 1)
(menu-bar-mode 0)
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

