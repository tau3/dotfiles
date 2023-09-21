(set-frame-font "JetBrainsMonoNL Nerd Font Mono 11" nil t)
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
(setq recentf-max-saved-items 100)
(setq calendar-week-start-day 1)
(add-hook 'calendar-today-visible-hook 'calendar-mark-today)

(require 'package)
(add-to-list
 'package-archives '("melpa" . "https://melpa.org/packages/")
 t)
(package-initialize)
(custom-set-variables
 '(elisp-autofmt-python-bin "/usr/bin/python3")
 '(mingus-current-song-props
   '(:weight bold :background "deep sky blue"))
 '(package-selected-packages
   '(elisp-autofmt async consult-lsp apt-sources-list dired-hide-dotfiles multi-vterm dirvish crontab-mode elfeed-summary elfeed undo-tree mingus xclip sudo-edit consult-dir disk-usage all-the-icons openwith vertico consult rainbow-delimiters evil-collection evil marginalia orderless solaire-mode doom-themes rust-mode dashboard reverse-im flycheck company lsp-treemacs lsp-ui lsp-mode markdown-mode magit git-gutter which-key which-key-mode)))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)
(use-package
 dirvish
 :init (dirvish-override-dired-mode)
 :config (setq dired-dwim-target t)
 (setq dirvish-mode-line-format
       '(:left (sort symlink) :right (omit yank index)))
 (setq dirvish-attributes '(file-time file-size vc-state))
 (setq
  dired-listing-switches
  "-l --almost-all --human-readable --group-directories-first --no-group")
 :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
 (:map
  dirvish-mode-map ; Dirvish inherits `dired-mode-map'
  ("N" . dirvish-narrow)
  ("h" . dired-up-directory)
  ("<left>" . dired-up-directory)
  ("<right>" . dired-find-file)
  ("l" . dired-find-file)
  ("j" . dired-next-line)
  ("k" . dired-previous-line)
  ("M-RET" . dired-find-file-other-window)
  ("s" . dirvish-quicksort) ; remapped `dired-sort-toggle-or-edit'
  ("M-l" . dirvish-ls-switches-menu)
  ("M-m" . dirvish-mark-menu)))

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
 (setq consult-preview-excluded-files
       '(".*\\.pdf"
         ".*\\.docx"
         ".*\\.mp4"
         ".*\\.webm"
         ".*sudo:root.*"))
 :bind ("C-x b" . consult-buffer) ("C-x j" . consult-recent-file))

(add-hook 'rust-mode-hook 'lsp-mode)
(use-package
 lsp-mode
 :defer t
 :hook
 ((lsp-mode . lsp-enable-which-key-integration)
  (lsp-mode . lsp-treemacs-sync-mode))
 :init
 (setq lsp-enable-snippet nil)
 (setq lsp-headerline-arrow "=>")
 (setq lsp-keymap-prefix "C-x l")
 (setq treemacs-is-never-other-window -1)
 (setq lsp-signature-doc-lines 3)
 (setq
  company-minimum-prefix-length 1
  company-idle-delay 0.0) ; default is 0.2
 :bind
 (:map
  lsp-mode-map
  ("M-RET" . lsp-execute-code-action)
  ("C-<f10>" . lsp-rust-analyzer-run)
  ("<f3>" . flycheck-next-error)
  ("<S-f3>" . flycheck-previous-error)
  ("<f6>" . lsp-rename)
  ("<f8>" . lsp-treemacs-symbols)
  ("C-<f12>" . consult-lsp-file-symbols)
  ("C-b" . lsp-find-definition))
 :config
 (define-key lsp-mode-map (kbd "C-x l") lsp-command-map)
 (add-hook 'lsp-on-change-hook 'save-buffer))

(use-package
 lsp-treemacs
 :defer t
 :config (global-set-key "\M-n" 'treemacs))

(use-package
 reverse-im
 :custom (reverse-im-input-methods '("russian-computer"))
 :config (reverse-im-mode t))

(use-package
 dashboard
 :config
 (setq dashboard-center-content t)
 (add-to-list 'recentf-exclude ".*\/.rustup\/.*")
 (add-to-list 'recentf-exclude ".*\.gpg")
 (setq dashboard-show-shortcuts nil)
 (setq dashboard-items '((recents . 15)))
 (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
 (setq dashboard-set-navigator t)
 (dashboard-setup-startup-hook))

(use-package
 evil
 :config
 (evil-set-initial-state 'vterm-mode 'emacs)
 (evil-set-initial-state 'disk-usage-mode 'emacs)
 (evil-set-initial-state 'dired-mode 'emacs)
 (evil-set-initial-state 'elfeed-show-mode 'emacs) ; when an entry is opened
 (evil-set-initial-state 'elfeed-search-mode 'emacs) ; when a feed is opened
 (evil-set-initial-state 'mingus-browse-mode 'emacs)
 (evil-set-initial-state 'mingus-playlist-mode 'emacs)
 (evil-set-undo-system 'undo-tree)
 (define-key evil-normal-state-map (kbd "C-/") 'comment-line)
 (define-key evil-insert-state-map (kbd "C-/") 'comment-line)
 :init
 (setq evil-want-keybinding nil)
 (setq evil-vsplit-window-right t)
 (setq evil-split-window-below t)
 (evil-mode))

(use-package
 evil-collection
 :after evil
 :config
 (define-key evil-motion-state-map [down-mouse-1] nil)
 (setq evil-collection-mode-list '(dashboard ibuffer xref))
 (evil-collection-init)
 (evil-collection-define-key
  'normal 'dired-mode-map "H" 'dired-hide-dotfiles-mode))

(use-package
 magit
 :defer t
 :config (add-hook 'git-commit-post-finish-hook 'delete-window))

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
   (local-set-key [return] 'tau3/disk-usage-enter)
   (local-set-key
    (kbd "d")
    (lambda ()
      (interactive)
      (disk-usage-delete-marked-files 1))))
 (add-hook 'disk-usage-mode-hook 'tau3/disk-usage-bind-local))

;; Scrolling settings
(setq scroll-step 1)
(setq scroll-conservatively 10000)

(when (file-exists-p "~/git/emacs/rss.el")
  (load-file "~/git/emacs/rss.el"))

(use-package
 elfeed-summary
 :defer t
 :config
 (defun tau3/press-enter ()
   (interactive)
   (execute-kbd-macro (read-kbd-macro "RET")))
 (defun tau3/elfeed-bind-keys ()
   (local-set-key (kbd "<mouse-1>") 'tau3/press-enter)
   (local-unset-key (kbd "C-<tab>")))
 (defun tau3/elfeed-bind-search-buttons ()
   (local-set-key (kbd "h") 'elfeed-search-quit-window)
   (local-set-key (kbd "j") 'next-line)
   (local-set-key (kbd "k") 'previous-line)
   (local-set-key (kbd "l") 'tau3/press-enter))
 (add-hook 'elfeed-search-mode-hook 'tau3/elfeed-bind-search-buttons)
 (add-hook 'elfeed-summary-mode-hook 'tau3/elfeed-bind-keys))

(which-key-mode 1)
(setq mingus-use-mouse-p nil)
(solaire-global-mode +1)
(delete-selection-mode t)
(global-git-gutter-mode +1)
(vertico-mode 1)
(marginalia-mode 1)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(xclip-mode 1) ; copy/yank to OS clipboard
(async-bytecomp-package-mode 1)

(use-package
 multi-vterm
 :defer t
 :config (setq vterm-timer-delay 0.01)
 (add-hook
  'vterm-mode-hook (lambda () (setq-local global-hl-line-mode nil))))
(defun tau3/vterm-other-window ()
  (interactive)
  (clone-indirect-buffer-other-window "terminal" t)
  (multi-vterm))
(global-set-key (kbd "C-x %") 'tau3/vterm-other-window)
(global-set-key (kbd "C-x `") 'multi-vterm)

(use-package
 display-line-numbers
 :init
 (setq display-line-numbers-type 'relative)
 (add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t))))

(global-set-key (kbd "M-o") 'ace-window)
(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-;") 'avy-goto-char-2)

(use-package
 doom-themes
 :ensure t
 :config
 (setq
  doom-themes-enable-bold t ; if nil, bold is universally disabled
  doom-themes-enable-italic t) ; if nil, italics is universally disabled
 (load-theme 'doom-tomorrow-night t)
 (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
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

(custom-set-faces
 '(calendar-today ((t (:background "snow" :foreground "grey17")))))
