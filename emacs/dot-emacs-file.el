(defun insert-random-string ()
  (interactive)
  (insert (format-time-string "%Y%m%d"))
  (setq num 0)
  (while (< num 4)
    (insert  (+ ?a (random (- ?z ?a))))
    (setq num (1+ num))))

(defun wc ()
  (interactive)
  (message "Word count: %s" (how-many "\\w+"                                                                                                                   (point-min) (point-max))))

(set-face-background 'modeline          "#88AAcc")

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(longlines-mode 't)
(line-number-mode 't)
(setq transient-mark-mode 't)
(put 'upcase-region 'disabled nil)
(random t)

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)