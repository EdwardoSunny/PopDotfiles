;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; transparent background
;; (set-frame-parameter (selected-frame) 'alpha '(90. 50))
;; (add-to-list 'default-frame-alist '(alpha . (90 . 50)))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; + `doom-font' -- the primary font to use
;; + `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; + `doom-unicode-font' -- for unicode glyphs
;; + `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 16 :weight 'semi-light)
     doom-variable-pitch-font (font-spec :family "FiraCode Nerd Font" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
;; (load-theme #'airline-soda t)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(load-theme #'doom-dracula t)
;; (load-theme #'inkpot t)
;; (load-theme #'abyss t)
;; (load-theme #'spacemacs-dark t)
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq display-line-numbers-type 'relative)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; Replace <your-project-root-path> with the actual root path of your Python project.


;; additional package configuration and other settings...
;; use fish shell
(setq-default explicit-shell-file-name "/bin/fish")
(setq vterm-shell "/bin/fish")
;; set preview org html viewere to xwidget cuz it has more support
(setq org-preview-html-viewer `xwidget)

;; lsp mode performance
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq lsp-idle-delay 0.500)

(with-eval-after-load 'lsp-mode
  ;; :global/:workspace/:file
  (setq lsp-modeline-diagnostics-scope :workspace))
;; switch between treemacs and window with SPC -
(defun +private/treemacs-back-and-forth ()
  (interactive)
  (if (treemacs-is-treemacs-window-selected?)
      (aw-flip-window)
    (treemacs-select-window)))

(map! :after treemacs
      :leader
      :n "-" #'+private/treemacs-back-and-forth)

(after! lsp-ui
  (setq lsp-ui-doc-enable t))

;; vterm dum
(setq vterm-always-compile-module t)
;; (setq projectile-project-search-path '("~/Documents/Code/"))

;; pip install pyright
;; sudo apt-get install python3-pylsp
;; pip install 'python-lsp-server[all]'

;; exec path from shell (makes sure emacs and shell has same env vars) so that conda in emacs will have same envs as conda in terminal
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
;; to get autocompletion for libaries, you need to use a venv inside of emacs --> e.g. add +conda after (python) in init.el
;; after having venv in conda, then you can activate environment and get the documnetation/completions

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; pip install black supports autoformatting for python --> do this outside of any conda envs

;; never lose cursor when scroll
(beacon-mode 1)


;; clippy elisp tips
;; describe function --> SPC c h f
;; describt variable --> SPC c h v
(map! :leader
      (:prefix ("c h" . "Help info from Clippy")
       :desc "Clippy describes function under point" "f" #'clippy-describe-function
       :desc "Clippy describes variable under point" "v" #'clippy-describe-variable))

;; mini map
;; SPC t m
;; (setq minimap-window-location 'right)
