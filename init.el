(add-to-list 'load-path "~/.emacs.d/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")

(require 'package)
(add-to-list 'package-archives
    '("marmalade" .  "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)

;; Start in fullscreen mode
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;;;;  AUTOCOMPLETE
(ac-config-default)

;; ;; PROJECTILE
(require 'projectile)
(projectile-global-mode)
(setq projectile-keymap-prefix (kbd "C-c C-p"))
(define-key projectile-mode-map (kbd "C-c C-p C-p") 'projectile-switch-project)
(define-key projectile-mode-map (kbd "C-c C-p C-f") 'projectile-find-file)
(define-key projectile-mode-map (kbd "C-c C-p C-t") 'projectile-toggle-between-implementation-and-test)

;; ;; C/C++ STYLE SETTINGS
(setq-default indent-tabs-mode nil)
(setq c-default-style "bsd") 
(setq-default c-basic-offset 4)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; AUTO DELETE-SELECTION
(delete-selection-mode 1)

;; SMOOTH SCROLLING
(setq scroll-margin 5
scroll-conservatively 9999
scroll-step 1)

;; ;; IDO-configuration
(require 'ido)
(ido-mode t)

;; ;; FONTS
(global-font-lock-mode 1) 


;; EVIL MODE SETTINGS
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key
  "f" 'find-file
  "b" 'switch-to-buffer
  "k" 'kill-buffer
  "pp" 'projectile-switch-project
  "pf" 'projectile-find-file
  "pk" 'projectile-kill-buffers
  "ss" 'split-window-horizontally
  "vv" 'split-window-vertically
  "dw"  'delete-window
  "do" 'delete-other-windows
  "sf" 'save-buffer
  "sa" 'save-some-buffers
  "g" 'magit-status)


(with-eval-after-load "evil"
     (evil-set-initial-state 'dired-mode 'emacs)
     (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
     (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
     (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
     (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)

     (define-key evil-normal-state-map "\C-e" 'evil-end-of-line)
     (define-key evil-insert-state-map "\C-e" 'end-of-line)
     (define-key evil-visual-state-map "\C-e" 'evil-end-of-line)
     (define-key evil-motion-state-map "\C-e" 'evil-end-of-line)
     
     (define-key evil-normal-state-map (kbd "M-k") (lambda ()
                                                     (interactive)
                                                     (evil-scroll-up nil)))
     (define-key evil-normal-state-map (kbd "M-j") (lambda ()
                        (interactive)
                        (evil-scroll-down nil))))
;; Clean modeline
(require 'diminish)
(diminish 'visual-line-mode)
(with-eval-after-load 'undo-tree (diminish 'undo-tree-mode))
(with-eval-after-load 'auto-complete (diminish 'auto-complete-mode))
(with-eval-after-load  'projectile (diminish 'projectile-mode))
(with-eval-after-load  'yasnippet (diminish 'yas-minor-mode))
(with-eval-after-load  'eldoc (diminish 'eldoc-mode))
(with-eval-after-load  'company (diminish 'company-mode))
(with-eval-after-load 'magiter-load  (diminish 'magit-auto-revert-mode))
(with-eval-after-load 'flycheck (diminish 'flycheck-mode))

;; POWERLINE
(require 'powerline-evil)
(powerline-evil-vim-color-theme)
(display-time-mode t)

;; CMAKE
(require 'rtags) ;; optional, must have rtags installed
(cmake-ide-setup)

;; IRONY
(add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)
    (add-hook 'objc-mode-hook 'irony-mode)

    ;; replace the `completion-at-point' and `complete-symbol' bindings in
    ;; irony-mode's buffers by irony-mode's asynchronous function
    (defun my-irony-mode-hook ()
      (define-key irony-mode-map [remap completion-at-point]
        'irony-completion-at-point-async)
      (define-key irony-mode-map [remap complete-symbol]
        'irony-completion-at-point-async))
    (add-hook 'irony-mode-hook 'my-irony-mode-hook)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;;; Disable auto-save and backups
(setq auto-save-default nil)
(setq make-backup-files nil)

;; Electric mode
(electric-pair-mode 1)

;; LINUM MODE
(linum-relative-global-mode 1)

;; Always show matching parenthesis
(show-smartparens-global-mode 1)


;;; Syntax-checking ;;;;;;;;
(add-hook 'after-init-hook #'global-flycheck-mode)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)
(defun ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "adobe" :slant normal :weight semi-bold :height 98 :width normal))))
 '(linum ((t (:background "#222120" :foreground "#666462")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(column-number-mode t)
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (badwolf)))
 '(custom-safe-themes
   (quote
    ("5ee12d8250b0952deefc88814cf0672327d7ee70b16344372db9460e9a0e3ffc" "cf08ae4c26cacce2eebff39d129ea0a21c9d7bf70ea9b945588c1c66392578d1" "1157a4055504672be1df1232bed784ba575c60ab44d8e6c7b3800ae76b42f8bd" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "6c0a087a4f49c04d4002393ffd149672f70e4ab38d69bbe8b39059b61682b61c" "405b0ac2ac4667c5dab77b36e3dd87a603ea4717914e30fcf334983f79cfd87e" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "38ba6a938d67a452aeb1dada9d7cdeca4d9f18114e9fc8ed2b972573138d4664" "28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" "519d1b3cb7345cc9be10b4b0489436ae2d1b0690470d8d78f8e4e1ff19b83a86" default)))
 '(fci-rule-color "#3E3D31")
 '(flycheck-c/c++-gcc-executable nil)
 '(flycheck-gcc-language-standard "c++11")
 '(global-linum-mode nil)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3E3D31" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#3E3D31" . 100))))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice t)
 '(linum-format " %1i ")
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(pos-tip-background-color "#A6E22E")
 '(pos-tip-foreground-color "#272822")
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (unspecified "#272822" "#3E3D31" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))


;; EVIL MODE
(require 'evil)
(evil-mode 1)


;; esc quits
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
(global-set-key [escape] 'evil-exit-emacs-state)
