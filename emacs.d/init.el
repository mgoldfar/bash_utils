(message "Loading my custom init.el")

;; Load package if >= v24
(when (>= emacs-major-version 24)
  (load "~/environment/emacs.d/init_packages.el"))

;; Disable that pesky startup screen
(custom-set-variables
 '(inhibit-startup-screen t))

;; Default C/C++ style
(setq c-default-style "bsd")
(setq-default indent-tabs-mode nil)
(setq-default tab-width 3)
(setq-default c-basic-offset 3)

;; Python indenting
(add-hook 'python-mode-hook
          (lambda ()
            (setq electric-indent-chars (delq ?: electric-indent-chars))))

;; Column and line numbers
(setq column-number-mode t)
(setq line-number-mode t)

;; Set major modes for additional extensiurens
(add-to-list 'auto-mode-alist '("\\.cl\\'" . c-mode)) ;; OpenCL kernels
(add-to-list 'auto-mode-alist '("\\.proto\\'" . c++-mode)) ;; Protobuf

;; custom key mappings for common spell checking operations
(global-set-key (kbd "<f6>") 'flyspell-mode)
(global-set-key (kbd "<f7>") 'flyspell-buffer)
(global-set-key (kbd "<f8>") 'ispell-word)

;; no verbose checking status (speeds things up)
(setq flyspell-issue-message-flag nil)

;; Up/Down arrown for emacs shell
(when (require 'comint nil 'noerror)
  (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
  (define-key comint-mode-map (kbd "<down>") 'comint-next-input))

;; Less spastic scrolling 
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time    
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(message "Finished loading init.el")
