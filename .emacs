;; Startup profiling: M-x use-package-report
(setq use-package-compute-statistics t)

(setq gc-cons-threshold most-positive-fixnum)

(require 'seq)
(require 'server)
(unless (server-running-p)
  (server-start))

(require 'package)
(add-to-list
 'package-archives '("melpa" . "https://melpa.org/packages/")
 t)
(custom-set-variables
 '(dirvish-preview-disabled-exts '("bin" "exe" "gpg" "elc" "eln" "doc" "docx" "xls"))
 '(eglot-ignored-server-capabilities '(:inlayHintProvider))
 '(elisp-autofmt-python-bin "/usr/bin/python3")
 '(package-selected-packages
   '(ace-window async avy consult consult-dir consult-eglot corfu dape dash dashboard diff-hl difftastic dired-hide-dotfiles dirvish doom-themes elisp-autofmt evil evil-collection evil-visualstar exec-path-from-shell expand-region gcmh ghostel haskell-ts-mode jinx latex-preview-pane magit magit-delta marginalia markdown-mode nerd-icons openwith orderless rainbow-delimiters reverse-im solaire-mode sudo-edit vertico which-key xclip)))

(defun tau3/open-new-tab ()
  (interactive)
  (tab-bar-new-tab)
  (ibuffer))

(defun tau3/magit-new-tab ()
  "Open magit status in its own tab, one tab per repository."
  (interactive)
  (let ((name
         (format "magit: %s"
                 (file-name-nondirectory
                  (directory-file-name
                   (or (vc-root-dir) default-directory))))))
    (if (seq-find
         (lambda (tab) (equal (alist-get 'name tab) name))
         (tab-bar-tabs))
        (tab-bar-select-tab-by-name name)
      (tab-bar-new-tab)
      (tab-bar-rename-tab name)
      (magit-status))))

(use-package
 emacs
 :custom
 (use-short-answers t)
 (vc-follow-symlinks t)
 (make-backup-files nil)
 (recentf-max-saved-items 100)
 (mouse-drag-and-drop-region t)
 (split-width-threshold 152 "Force allow vertical split on laptop with fira code 11.")
 (major-mode-remap-alist '((c++-mode . c++-ts-mode)))
 (display-line-numbers-type 'relative)
 :hook
 (prog-mode . display-line-numbers-mode)
 (prog-mode . subword-mode)
 :config
 (menu-bar-mode -1)
 (scroll-bar-mode -1)
 (tool-bar-mode -1)
 (xterm-mouse-mode 1)
 (column-number-mode 1)
 (savehist-mode 1)
 (global-hl-line-mode 1)
 (pixel-scroll-precision-mode 1)
 (delete-selection-mode 1)
 ;; Global keys. Set here rather than via :bind, which would make
 ;; use-package autoload undefined commands from a file named "emacs".
 (keymap-global-set "C-t" #'tau3/open-new-tab)
 (keymap-global-set "C-w" #'tab-bar-close-tab)
 (keymap-global-set "C-<f4>" #'tab-bar-close-tab)
 (keymap-global-set "M-o" #'ace-window)
 (keymap-global-set "C-/" #'comment-line)
 (keymap-global-set "C-x C-b" #'ibuffer)
 (keymap-global-set "C-x g" #'tau3/magit-new-tab)
 (keymap-global-set "C-;" #'avy-goto-char)
 (keymap-global-set "<f12>" #'which-key-show-top-level)
 (keymap-global-unset "<f11>"))

(use-package
 tab-bar
 :defer t
 :custom
 (tab-bar-new-button-show nil)
 (tab-bar-close-button-show nil))

(use-package gcmh :ensure t :hook (after-init . gcmh-mode))

(use-package
 doom-themes
 :ensure t
 :custom
 (doom-themes-enable-bold t) ; if nil, bold is universally disabled
 (doom-themes-enable-italic t) ; if nil, italics is universally disabled
 :config (load-theme 'doom-one t) (doom-themes-org-config))

(use-package solaire-mode :hook (after-init . solaire-global-mode))
(use-package which-key :hook (after-init . which-key-mode))
(use-package xclip :hook (after-init . xclip-mode)) ; copy/yank to OS clipboard
(use-package
 rainbow-delimiters
 :hook (prog-mode . rainbow-delimiters-mode))
(use-package expand-region :bind ("M-w" . er/expand-region))

(use-package
 reverse-im
 :custom (reverse-im-input-methods '("russian-computer"))
 :config (reverse-im-mode t))

(use-package vertico :hook (after-init . vertico-mode))
(use-package
 vertico-mouse
 :after vertico
 :config (vertico-mouse-mode 1))
(use-package marginalia :hook (after-init . marginalia-mode))

(use-package
 orderless
 :custom (completion-styles '(orderless basic))
 (completion-category-overrides
  '((file (styles basic partial-completion)))))

(use-package
 consult
 :custom
 ;; Use Consult to select xref locations with preview
 (xref-show-xrefs-function #'consult-xref)
 (xref-show-definitions-function #'consult-xref)
 (consult-preview-excluded-files
  (list
   (concat
    "\\."
    (regexp-opt
     '("pdf" "doc" "docx" "xls" "djvu" "mp3" "mp4" "mkv" "avi" "webm"))
    "\\'")
   "sudo:root"))
 :config
 (defun tau3/consult-recent-file-other-window ()
  (interactive)
  (let ((consult--buffer-display #'switch-to-buffer-other-window))
    (consult-recent-file)))
 :bind
 ("C-x b" . consult-buffer)
 ("C-x j" . consult-recent-file)
 ("C-x B" . consult-buffer-other-window)
 ("C-x J" . tau3/consult-recent-file-other-window))

(use-package
 consult-dir
 :ensure t
 :bind
 (("C-x C-d" . consult-dir)
  :map
  vertico-map
  ("C-x C-d" . consult-dir)
  ("C-x C-j" . consult-dir-jump-file)))

(use-package corfu :ensure t :defer t :custom (corfu-auto t))

(use-package dired-async :after dired :config (dired-async-mode 1))

;; In the `dirvish-side' window: mouse and TAB expand/collapse directories,
;; files open in the most recently used window. Regular dirvish is unaffected.
(define-minor-mode tau3/dirvish-side-tree-mode
  "Tree-style mouse and TAB bindings for the `dirvish-side' window."
  :keymap
  (define-keymap
   "<mouse-1>" #'dirvish-subtree-toggle-or-open
   "<mouse-2>" #'dirvish-subtree-toggle-or-open
   "TAB" #'dirvish-subtree-toggle))
(defun tau3/dirvish-side-setup ()
  (when (and (dirvish-curr) (eq (dv-type (dirvish-curr)) 'side))
    (tau3/dirvish-side-tree-mode 1)))

(use-package
 dirvish
 :init (dirvish-override-dired-mode)
 :custom
 (dired-dwim-target t)
 (dired-listing-switches
  "-l --almost-all --human-readable --group-directories-first --no-group")
 (dirvish-time-format-string "%d.%m.%y %R")
 (dirvish-mode-line-format
  '(:left (sort symlink) :right (omit yank index)))
 (dirvish-attributes '(file-time file-size vc-state))
 ;; Treemacs-like tree only in the `dirvish-side' window.
 (dirvish-side-attributes '(vc-state subtree-state nerd-icons collapse))
 :hook
 (dired-mode . dired-hide-dotfiles-mode)
 (dired-mode . auto-revert-mode)
 :config (add-hook 'dirvish-setup-hook #'tau3/dirvish-side-setup)
 :bind ; Bind `dirvish|dirvish-side|dirvish-dwim' as you see fit
 (:map
  dired-mode-map
  ("<mouse-2>" . dired-mouse-find-file) ; a click in dirvish won't open another panel
  ("<home>" . beginning-of-buffer)
  ("<end>" . end-of-buffer)
  ("C-t" . tau3/open-new-tab) ; overrides image-dired C-t prefix
  :map
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

(use-package
 openwith
 :custom
 (openwith-associations
  '(("\\.djvu\\'" "zathura" (file))
    ("\\.pdf\\'" "zathura" (file))
    ("\\.docx\\'" "libreoffice" (file))
    ("\\.xls\\'" "libreoffice" (file))
    ("\\.webm\\'" "mpv" (file))
    ("\\.mp4\\'" "mpv" (file))
    ("\\.avi\\'" "mpv" (file))
    ("\\.mkv\\'" "mpv" (file))))
 :config (openwith-mode t))

(use-package
 dashboard
 :custom
 (dashboard-center-content t)
 (dashboard-show-shortcuts nil)
 (dashboard-items '((recents . 15)))
 (dashboard-set-navigator t)
 (initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
 :config
 (add-to-list 'recentf-exclude "\\.gpg\\'")
 (dashboard-setup-startup-hook))

(use-package
 evil
 :custom
 (evil-want-keybinding nil)
 (evil-vsplit-window-right t)
 (evil-split-window-below t)
 :init (evil-mode)
 :config
 (evil-set-initial-state 'dired-mode 'emacs)
 (evil-set-undo-system 'undo-redo) ; built-in since Emacs 28
 (keymap-unset evil-motion-state-map "<down-mouse-1>")
 (dolist (map
          (list
           evil-motion-state-map evil-insert-state-map evil-emacs-state-map))
   (keymap-unset map "C-w"))
 (keymap-set evil-normal-state-map "C-/" #'comment-line)
 (keymap-set evil-insert-state-map "C-/" #'comment-line)
 (keymap-unset evil-normal-state-map "C-p")
 (keymap-unset evil-insert-state-map "C-p")
 (keymap-unset evil-normal-state-map "C-t")
 (keymap-unset evil-insert-state-map "C-t"))

(use-package
 evil-collection
 :after evil
 :custom (evil-collection-mode-list '(dashboard ibuffer xref))
 :config (evil-collection-init))

(use-package
 evil-visualstar
 :after evil
 :hook (after-init . global-evil-visualstar-mode))

(use-package
 magit
 :defer t
 :custom
 (magit-display-buffer-function
  #'magit-display-buffer-fullframe-status-v1)
 :bind (:map magit-mode-map ("C-w" . tab-bar-close-tab))
 :hook (git-commit-post-finish . delete-window))

;; Needs the git-delta binary (apt/brew install git-delta)
(use-package magit-delta :hook (magit-mode . magit-delta-mode))

(use-package
 diff-hl
 :ensure t
 :hook
 (after-init . global-diff-hl-mode)
 (magit-pre-refresh . diff-hl-magit-pre-refresh)
 (magit-post-refresh . diff-hl-magit-post-refresh)
 :config (diff-hl-flydiff-mode 1)
 ;; No fringe in a terminal frame: draw the markers in the margin.
 (unless (display-graphic-p)
   (diff-hl-margin-mode 1)))

(use-package
 ghostel
 :ensure t
 :defer t
 :custom
 (ghostel-query-before-killing nil)
 (ghostel-timer-delay 0.01)
 :init
 (with-eval-after-load 'evil
   (evil-set-initial-state 'ghostel-mode 'emacs))
 :hook
 (ghostel-mode . evil-emacs-state)
 (ghostel-readonly-change . tau3/evil-normal-in-ghostel-copy-mode)
 :config
 ;; Keys passed to Emacs instead of the shell, on top of ghostel's
 ;; defaults: C-t (`tau3/open-new-tab'), M-o (ace-window),
 ;; M-w (expand-region). `customize-set-variable' rebuilds the keymap.
 ;; C-q -> `ghostel-send-next-key' and C-c C-t (copy mode) are ghostel
 ;; defaults.
 (customize-set-variable
  'ghostel-keymap-exceptions
  (seq-union ghostel-keymap-exceptions '("C-t" "M-o" "M-w")))
 ;; In copy/emacs mode ghostel binds M-w to its own copy command;
 ;; drop it so the global `er/expand-region' works there too
 ;; (copy with evil `y' in visual state instead).
 (keymap-unset ghostel-readonly-mode-map "M-w")
 (defun tau3/evil-normal-in-ghostel-copy-mode ()
   (when (derived-mode-p 'ghostel-mode)
     (if buffer-read-only ; copy mode (C-c C-t) or emacs mode (C-c C-e)
         (evil-normal-state)
       (evil-emacs-state))))
 (defun tau3/delete-ghostel-window ()
   (when (derived-mode-p 'ghostel-mode)
     (let ((win (get-buffer-window (current-buffer))))
       (when
           (and win (window-parent win)) ; not the only window in frame
         (delete-window win)))))
 (add-hook 'kill-buffer-hook #'tau3/delete-ghostel-window))

(defun tau3/ghostel-split-right ()
  (interactive)
  (select-window (split-window-right))
  (ghostel-new))
(defun tau3/ghostel-split-below ()
  (interactive)
  (select-window (split-window-below))
  (ghostel-new))
(keymap-global-set "C-x %" #'tau3/ghostel-split-right)
(keymap-global-set "C-x \"" #'tau3/ghostel-split-below)
(keymap-global-set "C-x `" #'ghostel-new)

(use-package
 org
 :defer t
 :custom
 (org-emphasis-alist
  '(("*" (bold :foreground "Orange"))
    ("_" underline)
    ("=" (:background "maroon" :foreground "white"))
    ("~" (:background "deep sky blue" :foreground "MidnightBlue"))
    ("+" (:strike-through t))))
 :hook (org-mode . visual-line-mode))

(use-package
 eglot
 :defer t
 :bind
 (:map
  eglot-mode-map
  ("M-n" . dirvish-side)
  ("C-M-l" . eglot-format-buffer)
  ("M-RET" . eglot-code-action-quickfix)
  ("<f2>" . flymake-goto-next-error)
  ("S-<f2>" . flymake-goto-prev-error)
  ("M-<f2>" . flymake-goto-prev-error)
  ("<f6>" . eglot-rename)
  ("C-<f12>" . consult-imenu)
  ("M-<f7>" . xref-find-references)))

(defun tau3/init-lsp ()
  (eglot-ensure)
  (corfu-mode))
(add-hook 'c++-ts-mode-hook 'tau3/init-lsp)
(add-hook 'haskell-ts-mode-hook 'tau3/init-lsp)

(let ((my-ghcup-path (expand-file-name "~/.ghcup/bin")))
  (setenv "PATH" (concat my-ghcup-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-ghcup-path))

;;; Linux-specific
(when (eq system-type 'gnu/linux)
  ;; Applies to every frame, including ones made by emacsclient.
  (add-to-list 'default-frame-alist '(font . "Fira Code Retina-11")))

;;; macOS-specific
(when (eq system-type 'darwin)
  (require 'comp)
  (setq native-comp-driver-options
        (cons "-mmacosx-version-min=11" native-comp-driver-options))

  ;; Applies to every frame, including ones made by emacsclient.
  (add-to-list 'default-frame-alist '(font . "Fira Code Retina-13"))

  ;; GUI Emacs doesn't inherit PATH from the login shell.
  (use-package
   exec-path-from-shell
   :ensure t
   :if (memq window-system '(mac ns))
   :config (exec-path-from-shell-initialize))

  ;; Open documents and media with the default macOS apps
  ;; (overrides the Linux associations set in the `openwith' block).
  (with-eval-after-load 'openwith
    (setq openwith-associations
          `((,(concat
               "\\."
               (regexp-opt
                '("pdf" "djvu" "docx" "xls" "webm" "mp4" "avi" "mkv"))
               "\\'")
             "open" (file))))))

(custom-set-faces)
