(message "Loading my custom init.el")

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

;; If color-theme is installed apply our favorite colors
(when (require 'color-theme nil 'noerror)
  (when (display-graphic-p)
    (color-theme-initialize)
    (color-theme-deep-blue)))

;; Set major modes for additional extensions
(add-to-list 'auto-mode-alist '("\\.cl\\'" . c-mode))

;; custom key mappings for common spell checking operations
(global-set-key (kbd "<f6>") 'flyspell-mode)
(global-set-key (kbd "<f7>") 'flyspell-buffer)
(global-set-key (kbd "<f8>") 'ispell-word)

;; no verbose checking status (speeds things up)
(setq flyspell-issue-message-flag nil)

(message "Finished loading init.el")
