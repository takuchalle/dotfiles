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
(global-set-key (kbd "C-u") 'undo)

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

;; helm
(package-install 'helm)
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

(package-install 'helm-gtags)
(require 'helm-tags)
(global-set-key (kbd "M-.") 'helm-gtags-find-tag)
(global-set-key (kbd "M-*") 'helm-gtags-pop-stack)
(global-set-key (kbd "M-/") 'helm-gtags-find-rtag)

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

(when (require 'server nil t)
  (unless (server-running-p)
    (server-start)))