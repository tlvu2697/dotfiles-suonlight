(defun sl/new-workspace-and-vterm ()
  (interactive)
  (+workspace/new)
  (multi-vterm))

(defun sl/new-vterm-and-split ()
  (interactive)
  (split-window-below)
  (evil-window-down 1)
  (multi-vterm))

(defun sl/new-vterm-and-vsplit ()
  (interactive)
  (split-window-right)
  (evil-window-right 1)
  (multi-vterm))

(defun sl/draft-pr ()
  (interactive)
  (if (use-region-p)
    (let* ((pr-title (buffer-substring-no-properties (region-beginning) (region-end)))
            (draft-pr-title (format "---\ntitle: %s\ndraft: true\n---" (s-trim pr-title))))
      (delete-region (region-beginning) (region-end))
      (insert draft-pr-title))))

(defun sl/make-draft-pr ()
  (interactive)
  (let* ((line-beg-pos (line-beginning-position))
          (line-end-pos (line-end-position))
          (pr-title (buffer-substring-no-properties line-beg-pos line-end-pos))
          (pr-template-file (if (file-exists-p (concat (projectile-project-root) ".github/PULL_REQUEST_TEMPLATE"))
                              (concat (projectile-project-root) ".github/PULL_REQUEST_TEMPLATE")
                              (concat (projectile-project-root) "PULL_REQUEST_TEMPLATE.md")))
          (pr-template (with-temp-buffer
                         (erase-buffer)
                         (insert-file pr-template-file)
                         (buffer-string)))
          (draft-pr-title (->> pr-title
                            (s-trim)
                            (s-replace "# " "")
                            (format "---\ntitle: %s\ndraft: true\n---\n"))))
    (delete-region line-beg-pos line-end-pos)
    (insert draft-pr-title)
    (insert pr-template)))

(defun sl/build-reports (file)
  (find-file file)
  (org-babel-execute-buffer))

(defun sl/run-reports (report)
  (with-current-buffer report
    (goto-char (point-min))
    (while (re-search-forward "tmux .* :file" nil t 1) (org-open-at-point))))
