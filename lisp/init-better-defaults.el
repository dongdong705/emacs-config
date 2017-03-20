(setq make-backup-files nil)
(setq auto-save-default nil)
(global-linum-mode t)

(abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ;;signature
					    ("xj" "Baobao loves Zhuzhu")
					    ))



(put 'dired-find-alternate-file 'disable nil)

(with-eval-after-load 'dired
  (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))

(require 'dired-x)
(setq dired-dwim-target t)

(provide 'init-better-defaults)
