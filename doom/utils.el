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

(setq sl/jira-cache (make-hash-table :test 'equal))

(defun sl/make-draft-pr ()
  (interactive)
  (let* ((line-beg-pos (line-beginning-position))
          (line-end-pos (line-end-position))
          (pr-title (buffer-substring-no-properties line-beg-pos line-end-pos))
          (pr-template-file (cond ((file-exists-p (concat (projectile-project-root) ".github/PULL_REQUEST_TEMPLATE"))
                                    (concat (projectile-project-root) ".github/PULL_REQUEST_TEMPLATE"))
                              ((file-exists-p (concat (projectile-project-root) ".github/PULL_REQUEST_TEMPLATE.md"))
                                (concat (projectile-project-root) ".github/PULL_REQUEST_TEMPLATE.md"))
                              (t (concat (projectile-project-root) "PULL_REQUEST_TEMPLATE.md"))))
          (current-branch (magit-get-current-branch))
          (pr-template (with-temp-buffer
                         (erase-buffer)
                         (insert-file pr-template-file)
                         (buffer-string)))
          (draft-pr-title (->> (or (gethash current-branch sl/jira-cache) pr-title)
                            (s-trim)
                            (s-replace "# " "")
                            (format "---\ntitle: %s\ndraft: true\n---\n")))
          (issue-url (->> current-branch
                       (s-split "--")
                       (nth 1)
                       (s-concat "https://employmenthero.atlassian.net/browse/")))
          (commits (->> (format "%s log --pretty=format:\"- %s\" %s..HEAD" magit-git-executable "%s" forge--buffer-base-branch)
                     (shell-command-to-string))))
    (delete-region (point-min) (point-max))
    (insert draft-pr-title)
    (insert pr-template)
    (delete-region (point) (point-max))
    (goto-char (point-min))
    (re-search-forward "^# ")
    (+default/newline-below)
    (+default/newline-below)
    (insert issue-url)
    (re-search-forward "^# ")
    (+default/newline-below)
    (+default/newline-below)
    (insert commits)
    (evil-normal-state)))

(defun sl/build-reports (file)
  (find-file file)
  (org-babel-execute-buffer))

(defun sl/run-reports (report)
  (with-current-buffer report
    (goto-char (point-min))
    (while (re-search-forward "tmux .* :file" nil t 1) (org-open-at-point))))
