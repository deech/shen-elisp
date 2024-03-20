(defun update (version)
  "update shen-elisp to shen VERSION."
  (progn
    (require 'org)
    (shell-command
     (concat
      "curl -LO "
      "https://github.com/Shen-Language/shen-sources/releases/download/shen-" version "/ShenOSKernel-" version ".zip"))
    (shell-command   (concat "unzip " "ShenOSKernel-" version ".zip"))
    (let ((dl-kl-dir (concat "ShenOSKernel-" version "/klambda/")))
      (dolist (klfile
               (nthcdr 2 (directory-files dl-kl-dir nil)))
        (copy-file (concat dl-kl-dir klfile)
                   (concat "KLambda/" klfile) t))
      (message "Updated KLambda/, may need to update shen-elisp.org...")
      (org-babel-tangle-file "shen-elisp.org")
      (load-file "shen-primitives.el")
      (load-file "install.el")
      (runner))))

(update "38.1")
