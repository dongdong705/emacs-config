(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(require 'cl)

;;add whatever packages you want here
(defvar baobao/packages '(
			  company
			  monokai-theme
			  hungry-delete
			  counsel
			  swiper
			  smartparens
			  js2-mode
			  nodejs-repl
			  exec-path-from-shell
			  popwin
			  web-mode
			  iedit
			  expand-region
			  helm-ag
			  flycheck
			  auto-yasnippet
			  ) "Default packages")

(defun baobao/packages-installed-p ()
  (loop for pkg in baobao/packages
	when (not (package-installed-p pkg)) do (return nil)
	finally (return t)))

(unless (baobao/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg baobao/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(require 'hungry-delete)
(global-hungry-delete-mode)

(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

(global-flycheck-mode t)

(define-advice show-paren-function (:around (fn) fix-show-paren-function)
  "Highlight enclosing parens."
  (cond ((looking-at-p "\\s(") (funcall fn))
	(t (save-excursion
	     (ignore-errors (backward-up-list))
	     (funcall fn)))))

;;(add-hook 'emacs-lisp-mode-hook 'show-parens-mode)
(smartparens-global-mode t)
(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

(require 'popwin)
(popwin-mode t)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;config js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode))
       auto-mode-alist))

;; elpy-- main actor
(require 'elpy)
(elpy-enable)
;; enable elpy jedi backend
(setq elpy-rpc-backend "jedi")
(remove-hook 'elpy-modules 'elpy-module-flymake)

(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)


;(global-linum-mode t)
(global-company-mode t)

(load-theme 'monokai t)

;(require 'iedit)
(global-set-key (kbd "M-s e") 'iedit-mode)

(provide 'init-packages)
