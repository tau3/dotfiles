
;;; Code:
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
    (apt-sources-list yaml-mode flycheck-haskell hindent smex haskell-mode auto-complete))))

;; haskell-mode stuff
(package-initialize)
(ac-config-default)
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'haskell-mode-hook #'hindent-mode)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "C-c <right>") 'forward-sentence)
(global-set-key (kbd "C-c <left>") 'backward-sentence)
(ido-mode 1)
(menu-bar-mode 0)
(tool-bar-mode 0)
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
(add-hook 'haskell-mode-hook
       (lambda ()
		   (local-set-key (kbd "<f2>") 'flycheck-next-error)
		   (local-set-key (kbd "C-<f2>") 'flycheck-previous-error)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(when window-system
  ; (set-frame-font "Fira Code-14")
  ; https://github.com/ianpan870102/Emacs-Tron-Theme
  (load-theme `tron t)
  (set-frame-font "Fira Code-14"))

(provide '.emacs)
;;; .emacs ends here

