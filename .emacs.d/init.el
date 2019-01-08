;; encoding
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8-unix)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)

;; Global Key Binds
(global-set-key (kbd "C-m") 'newline-and-indent)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-t") 'other-window)
(global-set-key (kbd "C-z") 'undo)

(setq indent-tabs-mode nil)
(setq-default tab-width 4)

;; disable menu when terminal
(when (eq window-system 'nil)
  (menu-bar-mode 0))

(setq initial-scratch-message nil)

(setq completion-ignore-case t)

;; display some infomation
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

(setq gc-cons-threshold (* 10 gc-cons-threshold))

(global-auto-revert-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

;; mark file begins "#!" as executable
(add-hook 'after-save-hook
	  'executable-make-buffer-file-executable-if-script-p)
;;
;; Ignore "Suspicious line XXX. Save anyway"
;; when save Makefile.
(add-hook 'makefile-mode-hook
	  (function (lambda ()
		      (fset 'makefile-warn-suspicious-lines 'ignore))))

(show-paren-mode t)

;; backup
(setq make-backup-files t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/.backup"))
	    backup-directory-alist))

;; plugin management
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(package-refresh-contents)

(package-install 'use-package)

;; color setting
(package-install 'dracula-theme)
(load-theme 'dracula t)

;; ivy
(package-install 'ivy)
(package-install 'counsel)
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;; magit
(package-install 'magit)
(global-set-key (kbd "C-x g") 'magit-status)

;; company-mode
(package-install 'company)
(global-company-mode)
(setq company-idle-delay 0.3) ; default is 0.5
(setq company-minimum-prefix-length 3) ; default is 4
(setq company-selection-wrap-around t) ; 

(define-key company-active-map (kbd "C-n") 'company-select-next)
(define-key company-active-map (kbd "C-p") 'company-select-previous)
(define-key company-active-map (kbd "C-h") nil)
(define-key company-active-map (kbd "C-s") 'company-filter-candidates)
(define-key company-active-map (kbd "C-i") 'company-complete-selection)

(define-key company-search-map (kbd "C-n") 'company-select-next)
(define-key company-search-map (kbd "C-p") 'company-select-previous)

;; irony
(package-install 'irony)
(package-install 'company-irony)

;; markdown
(package-install 'markdown-mode)
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; auto save
(package-install 'auto-save-buffers-enhanced)
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 0.5)
(auto-save-buffers-enhanced t)

;; mwim
;; http://emacs.rubikitch.com/mwim/
(package-install 'mwim)
(global-set-key (kbd "C-a") 'mwim-beginning-of-code-or-line)
(global-set-key (kbd "C-e") 'mwim-end-of-code-or-line)

;;
;; smartparens
;; http://kiririmode.hatenablog.jp/entry/20131231/p1
(package-install 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)

;; recentf
(require 'recentf)
(setq recentf-max-saved-items 100)
(setq recentf-exclude '("recentf"))
(setq recentf-auto-save-timer (run-with-idle-timer 30 t 'recentf-save-list))
(recentf-mode 1)
(global-set-key (kbd "C-x C-r") 'counsel-recentf)

;; fish-mode
(package-install 'fish-mode)
(require 'fish-mode)

;; swift-mode
(package-install 'swift-mode)

(defun today()
  (interactive)
  (insert (format-time-string "%Y/%m/%d" (current-time))))

(package-install 'google-c-style)
(require 'google-c-style)

(defun cc-mode-init ()
  (google-set-c-style)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4)
  (c-set-offset 'case-label -1)
  (c-set-offset 'inextern-lang 0)
  )

(add-hook 'c-mode-hook 'cc-mode-init)
(add-hook 'c++-mode-hook 'cc-mode-init)

;; TypeScript
(package-install 'typescript-mode)
(require 'typescript-mode)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(package-install 'tide)
(require 'tide)
(add-hook 'typescript-mode-hook
		  (lambda ()
			(interactive)
			(tide-setup)
			(flycheck-mode +1)
			(setq flycheck-check-syntax-automatically '(save mode-enabled))
			(eldoc-mode +1)
			(tide-hl-identifier-mode +1)
			(company-mode +1)
			(global-set-key (kbd "M-*") 'tide-jump-back)))

(add-hook 'before-save-hook 'tide-format-before-save)

(package-install 'highlight-symbol)
(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.5) ;; highlight after 0.5s idle
(add-hook 'prog-mode-hook 'highlight-symbol-mode) ;; turn on when programming lang file is open
(add-hook 'prog-mode-hook 'highlight-symbol-nav-mode) ;; use M-p/M-n to move between symble

(package-install 'yaml-mode)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))

(package-install 'go-mode)

(package-install 'dart-mode)
(setq dart-enable-analysis-server t)
(add-hook 'dart-mode-hook 'flycheck-mode)

(when (executable-find "cmigemo")
  (package-install 'migemo)
  (require 'migemo)
  (setq migemo-command (executable-find "cmigemo"))
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8)
  (load-library "migemo")
  (migemo-init)
  )

;; Language Server Protocol
(package-install 'lsp-mode)
(package-install 'lsp-ui)
(package-install 'company-lsp)


;; snippet
(package-install 'yasnippet)
(package-install 'yasnippet-snippets)
(package-install 'ivy-yasnippet)
(require 'yasnippet)
(require 'ivy-yasnippet)
(setq yas-snippet-dirs
	  '("~/.emacs.d/snippets"
		"~/.emacs.d/elpa/snippets"))
(yas-global-mode 1)
