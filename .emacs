(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(ido-mode 1)
(menu-bar-mode 0)
(custom-set-faces)
(global-display-line-numbers-mode)
