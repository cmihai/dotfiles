(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'evil)
(define-key evil-insert-state-map "\C-c" (lambda () (interactive) (evil-normal-state)))

(modify-syntax-entry ?_ "w" (standard-syntax-table))
