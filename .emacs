(setq gc-cons-threshold most-positive-fixnum)
(add-hook
 ;; 800000 is the default value
 'after-init-hook (lambda () (setq gc-cons-threshold (800000))))
;; for mystical reasons tuning gc threshold breaks magit initialization.
(global-set-key (kbd "C-x g") 'magit-status)

(set-frame-font "Fira Code Retina 11" nil t)
(setq split-width-threshold 152) ; force allow vertical split on laptop with fira code 11
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(xterm-mouse-mode 1)
(show-paren-mode 1) ; highlight parens pairs
(setq vc-follow-symlinks t)
(setq make-backup-files nil)
(column-number-mode t)
(savehist-mode)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-hl-line-mode t)
(pixel-scroll-precision-mode 1)
(setq recentf-max-saved-items 100)
(setq mouse-drag-and-drop-region t)

(require 'package)
(add-to-list
 'package-archives '("melpa" . "https://melpa.org/packages/")
 t)
(package-initialize)
(custom-set-variables
 '(elisp-autofmt-python-bin "/usr/bin/python3")
 '(package-selected-packages
   '(all-the-icons apt-sources-list async company consult consult-dir consult-lsp dashboard dired-hide-dotfiles dirvish disk-usage doom-themes elisp-autofmt evil evil-collection expand-region flycheck git-gutter lsp-mode lsp-treemacs lsp-ui magit marginalia markdown-mode multi-vterm openwith orderless rainbow-delimiters reverse-im solaire-mode sudo-edit undo-tree vertico which-key which-key-mode xclip)))

(defun tau3/open-new-tab ()
  (interactive)
  (tab-bar-new-tab)
  (ibuffer))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)
(use-package
 dirvish
 :init (dirvish-override-dired-mode)
 :config
 (setq dired-dwim-target t)
 (setq dirvish-time-format-string "%d.%m.%y %R")
 (setq dirvish-mode-line-format
       '(:left (sort symlink) :right (omit yank index)))
 (setq dirvish-attributes '(file-time file-size vc-state))
 (setq
  dired-listing-switches
  "-l --almost-all --human-readable --group-directories-first --no-group")
 (add-hook
  'dired-mode-hook
  (lambda ()
    (dired-hide-dotfiles-mode)
    (auto-revert-mode)))
 (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file) ; a click in dirvish won't open another panel
 (defun tau3/dirvish-bind-local ()
   (local-set-key
    [home]
    (lambda ()
      (interactive)
      (beginning-of-buffer)))
   (local-set-key (kbd "C-t") 'tau3/open-new-tab)
   (local-set-key
    [end]
    (lambda ()
      (interactive)
      (end-of-buffer))))
 (add-hook 'dired-mode-hook 'tau3/dirvish-bind-local)
 :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
 (:map
  dirvish-mode-map ; Dirvish inherits `dired-mode-map'
  ("N" . dirvish-narrow)
  ("h" . dired-up-directory)
  ("H" . dired-hide-dotfiles-mode)
  ("<backspace>" . dired-up-directory)
  ("<left>" . dired-up-directory)
  ("<right>" . dired-find-file)
  ("l" . dired-find-file)
  ("j" . dired-next-line)
  ("k" . dired-previous-line)
  ("M-RET" . dired-find-file-other-window)
  ("s" . dirvish-quicksort) ; remapped `dired-sort-toggle-or-edit'
  ("M-l" . dirvish-ls-switches-menu)
  ("M-m" . dirvish-mark-menu)))

(use-package expand-region :bind ("M-w" . er/expand-region))

(use-package
 openwith
 :config (openwith-mode t)
 (setq openwith-associations
       '(("\\.djvu\\'" "zathura" (file))
         ("\\.pdf\\'" "zathura" (file))
         ("\\.docx\\'" "libreoffice" (file))
         ("\\.webm\\'" "mpv" (file))
         ("\\.mp4\\'" "mpv" (file))
         ("\\.mkv\\'" "mpv" (file)))))

(use-package
 consult-dir
 :ensure t
 :bind
 (("C-x C-d" . consult-dir)
  :map
  vertico-map
  ("C-x C-d" . consult-dir)
  ("C-x C-j" . consult-dir-jump-file)))

(use-package
 orderless
 :custom (completion-styles '(orderless basic))
 (completion-category-overrides
  '((file (styles basic partial-completion)))))

(use-package
 consult
 :config
 (defun tau3/consult-recent-file-other-window ()
   (interactive)
   (let ((tau3--buf-name (buffer-name)))
     (clone-indirect-buffer-other-window tau3--buf-name t)
     (consult-recent-file)))
 (setq consult-preview-excluded-files
       '(".*\\.pdf"
         ".*\\.docx"
         ".*\\.mkv"
         ".*\\.mp4"
         ".*\\.djvu"
         ".*\\.mp3"
         ".*\\.mkv"
         ".*\\.webm"
         ".*sudo:root.*"))
 :bind
 ("C-x b" . consult-buffer)
 ("C-x j" . consult-recent-file)
 ("C-x B" . consult-buffer-other-window)
 ("C-x J" . tau3/consult-recent-file-other-window))

(add-hook 'c++-mode-hook 'lsp-mode)
(use-package
 lsp-mode
 :defer t
 :hook
 ((lsp-mode . lsp-enable-which-key-integration)
  (lsp-mode . lsp-treemacs-sync-mode))
 :init
 (setq lsp-ui-sideline-show-diagnostics nil)
 (setq
  lsp-pylsp-plugins-autopep8-enabled t
  lsp-pylsp-plugins-pydocstyle-enabled nil
  lsp-pylsp-plugins-pylint-enabled t
  lsp-pylsp-plugins-yapf-enabled t)
 (setq lsp-enable-snippet nil)
 (setq lsp-headerline-arrow "=>")
 (setq lsp-keymap-prefix "C-x l")
 (setq treemacs-is-never-other-window -1)
 ;; (setq lsp-signature-doc-lines 3)
 (setq
  company-minimum-prefix-length 1
  company-idle-delay 0.0) ; default is 0.2
 :bind
 (:map
  lsp-mode-map
  ("C-p" . lsp-ui-doc-glance)
  ("C-M-l" . lsp-format-buffer)
  ("M-RET" . lsp-execute-code-action)
  ("<f2>" . flycheck-next-error)
  ("<S-f2>" . flycheck-previous-error)
  ("<f6>" . lsp-rename)
  ("<f8>" . lsp-treemacs-symbols)
  ("C-<f12>" . consult-lsp-file-symbols))
 :config
 (defun tau3/gd-other-window ()
   (interactive)
   (let ((tau3--buf-name (buffer-name)))
     (clone-indirect-buffer-other-window tau3--buf-name t)
     (evil-goto-definition)))
 (define-key lsp-mode-map (kbd "C-x l") lsp-command-map)
 (define-key evil-normal-state-map (kbd "g-D") 'tau3/gd-other-window)
 (global-unset-key (kbd "C-x C-l"))
 (add-hook 'lsp-on-change-hook 'save-buffer))

(use-package
 lsp-treemacs
 :defer t
 :bind (:map treemacs-mode-map ("\M-n" . treemacs))
 :config
 (define-key treemacs-mode-map "\M-n" 'treemacs)
 (global-set-key "\M-n" 'treemacs)
 (require 'ace-window)
 (setq aw-ignored-buffers (delq 'treemacs-mode aw-ignored-buffers)))

(use-package
 reverse-im
 :custom (reverse-im-input-methods '("russian-computer"))
 :config (reverse-im-mode t))

(use-package
 dashboard
 :config
 (setq dashboard-center-content t)
 (add-to-list 'recentf-exclude ".*\.gpg")
 (setq dashboard-show-shortcuts nil)
 (setq dashboard-items '((recents . 15)))
 (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
 (setq dashboard-set-navigator t)
 (dashboard-setup-startup-hook))

(use-package
 evil
 :config
 (evil-set-initial-state 'disk-usage-mode 'emacs)
 (evil-set-initial-state 'dired-mode 'emacs)
 (evil-set-undo-system 'undo-tree)
 (define-key evil-normal-state-map (kbd "C-/") 'comment-line)
 (define-key evil-insert-state-map (kbd "C-/") 'comment-line)
 (define-key evil-normal-state-map (kbd "C-p") nil)
 (define-key evil-insert-state-map (kbd "C-p") nil)
 (define-key evil-normal-state-map (kbd "C-t") nil)
 (define-key evil-insert-state-map (kbd "C-t") nil)
 :init
 (setq evil-want-keybinding nil)
 (setq evil-vsplit-window-right t)
 (setq evil-split-window-below t)
 (evil-mode)
 (eval-after-load "evil-maps"
   (dolist (map
            '(evil-motion-state-map
              evil-insert-state-map evil-emacs-state-map))
     (define-key (eval map) "\C-w" nil))))

(use-package
 evil-collection
 :after evil
 :config
 (define-key evil-motion-state-map [down-mouse-1] nil)
 (setq evil-collection-mode-list '(dashboard ibuffer xref))
 (evil-collection-init))

(use-package
 magit
 :defer t
 :config
 (setq magit-display-buffer-function
       #'magit-display-buffer-fullframe-status-v1)
 (add-hook 'git-commit-post-finish-hook 'delete-window))

(use-package
 disk-usage
 :defer t
 :config
 (defun tau3/disk-usage-enter ()
   (interactive)
   (move-end-of-line 1)
   (left-char 1)
   (push-button)
   (move-beginning-of-line 1))
 (defun tau3/disk-usage-bind-local ()
   (local-set-key (kbd "<home>") 'beginning-of-buffer)
   (local-set-key (kbd "<end>") 'end-of-buffer)
   (local-set-key [return] 'tau3/disk-usage-enter)
   (local-set-key
    (kbd "d")
    (lambda ()
      (interactive)
      (disk-usage-delete-marked-files 1))))
 (add-hook 'disk-usage-mode-hook 'tau3/disk-usage-bind-local))

(which-key-mode 1)
(solaire-global-mode +1)
(delete-selection-mode t)
(global-git-gutter-mode +1)
(vertico-mode 1)
(marginalia-mode 1)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(add-hook 'prog-mode-hook 'subword-mode)
(xclip-mode 1) ; copy/yank to OS clipboard
(async-bytecomp-package-mode 1)

(use-package
 multi-vterm
 :defer t
 :hook
 (vterm-mode . evil-emacs-state)
 (vterm-copy-mode . tau3/evil-normal-in-vterm-copy-mode)
 :bind (:map vterm-mode-map ("\C-q" . vterm-send-next-key))
 :config
 (defun tau3/vterm-kill-with-no-query (&rest _)
   (set-process-query-on-exit-flag
    (get-buffer-process (current-buffer)) nil))
 (advice-add 'multi-vterm :after #'tau3/vterm-kill-with-no-query)
 (setq multi-vterm-dedicated-window-height 10)
 (setq vterm-timer-delay 0.01)
 (defun tau3/evil-normal-in-vterm-copy-mode ()
   (if (bound-and-true-p vterm-copy-mode)
       (evil-normal-state)
     (evil-emacs-state)))
 (defun tau3/delete-vterm-window ()
   (when (eq major-mode 'vterm-mode)
     (when (not (one-window-p))
       (delete-window))))
 (add-hook 'kill-buffer-hook #'tau3/delete-vterm-window)
 (add-hook
  'vterm-mode-hook (lambda () (setq-local global-hl-line-mode nil))))
(defun tau3/vterm-other-window ()
  (interactive)
  (let ((tau3--buf-name (buffer-name)))
    (clone-indirect-buffer-other-window tau3--buf-name t)
    (multi-vterm)))
(global-set-key (kbd "C-x %") 'tau3/vterm-other-window)
(global-set-key (kbd "C-x `") 'multi-vterm)

(use-package
 display-line-numbers
 :init
 (setq display-line-numbers-type 'relative)
 (add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t))))

(global-set-key (kbd "C-t") 'tau3/open-new-tab)
(global-set-key (kbd "C-w") 'tab-bar-close-tab)
(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-;") 'avy-goto-char)
(global-set-key (kbd "<f12>") 'which-key-show-top-level)

(use-package
 doom-themes
 :ensure t
 :config
 (setq
  doom-themes-enable-bold t ; if nil, bold is universally disabled
  doom-themes-enable-italic t) ; if nil, italics is universally disabled
 (load-theme 'doom-one t)
 (setq doom-themes-treemacs-theme "doom-xcode") ; use "doom-colors" for less minimal icon theme
 (doom-themes-treemacs-config) (doom-themes-org-config))

(use-package
 org
 :mode (("\\.org$" . org-mode))
 :config
 (setq org-emphasis-alist
       '(("*" (bold :foreground "Orange"))
         ("_" underline)
         ("=" (:background "maroon" :foreground "white"))
         ("~" (:background
           "deep sky blue"
           :foreground "MidnightBlue"))
         ("+" (:strike-through t))))
 (add-hook 'org-mode-hook #'visual-line-mode))

(use-package
 undo-tree
 :ensure t
 :config (global-undo-tree-mode t)
 ;; workaround for problems on the edge between evil mode and undo tree:
 ;; https://github.com/syl20bnr/spacemacs/issues/14064
 (with-eval-after-load 'undo-tree
   (defun undo-tree-overridden-undo-bindings-p ()
     nil))
 :custom (undo-tree-auto-save-history nil))

(use-package
 tab-bar
 :defer t
 :config
 (setq tab-bar-new-button-show nil)
 (setq tab-bar-close-button-show nil))

(custom-set-faces)
