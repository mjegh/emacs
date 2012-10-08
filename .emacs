; http://www.emacswiki.org/cgi-bin/wiki/SiteMap
; https://github.com/genehack/emacs
;
; 00X001 commented out hm-html-mode stuff as html-helper used instead
; 00X002 added html-helper-mode
; 00X003 changed commented out hm-html-mode as installed 5.8
; 00X004 Added fset for yes-or-no-p so I don't have to type "yes" or "no"
;
; Automatic compilation support (mostly from wbrodie@panix.com)
;
; Stop any system default init file being loaded.
;
(autoload 'font-lock-mode "font-lock-mode" "Yay FontLock" t)
(global-font-lock-mode t )
(setq font-lock-maximum-size 1000000)
(setq font-lock-global-modes (quote (c-mode)))
(setq inhibit-default-init t)
(setq default-tab-width 4)
(setq tab-width 4)
; utf-8
;(require 'un-define)
;; by default xemacs does not autodetect Unicode
(prefer-coding-system 'utf-8)
;
; bookmarks
;
; C-x r l lists all of your bookmarks
(define-key global-map [f9] 'bookmark-jump)
(define-key global-map [f10] 'bookmark-set)
(setq bookmark-save-flag 1)		; How many mods between saves
;(set-coding-category-system 'utf-8 'utf-8))
;
; prefer spaces over tabs except when editing make files
;
(setq-default indent-tabs-mode nil)
(add-hook 'makefile-mode-hook (lambda () (setq indent-tabs-mode t)))
; fontlock
(autoload 'font-lock-mode "font-lock-mode" "Yay FontLock" t)
(global-font-lock-mode t )
(setq font-lock-maximum-size 1000000)
(setq font-lock-global-modes '(not text-mode))
;;;;;;(setq font-lock-global-modes (quote (c-mode)))
;
(setq redisplay-dont-pause t)
;
; As our emacs is dumped with c-mode.el we need to get rid of it.
;
(fmakunbound 'c-mode)
(makunbound 'c-mode-map)
(fmakunbound 'c++-mode)
(makunbound 'c++-mode-map)
(makunbound 'c-style-alist)
;
; visible bell
;
(setq visible-bell t)
; make scripts executable on saving
(add-hook'after-save-hook'
executable-make-buffer-file-executable-if-script-p)
;
; alias perl-mode to cperl-mode (it's better)
;
;;  We always prefer CPerl mode to Perl mode.
(fset 'perl-mode 'cperl-mode)
;;  When starting load my hooks
(add-hook 'cperl-mode-hook 'my-cperl-mode-hook t)
(add-hook 'cperl-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

(defun my-cperl-mode-hook ()
  (setq cperl-hairy t)
  (setq cperl-indent-level 4)
  (setq cperl-continued-statement-offset 4)
  (setq cperl-electric-keywords nil)
  (setq cperl-electric-parens-string "")
  (setq cperl-font-lock t)
  (setq cperl-indent-parens-as-block t))
;;;;;(defalias 'perl-mode 'cperl-mode)
;;;;;(setq cperl-hairy t)
;;;;;(setq cperl-indent-level 4)
;;;;;#(setq cperl-electric-parens-string "{[]}<")
;;;;;(setq cperl-electric-parens-string "")
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))

(require 'flymake)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-no-changes-timeout 5)
; replace normal compile mode
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
;
;;;;;(autoload 'pls-mode  "pls-mode" "PL/SQL Editing Mode" t)
;;;;;(autoload 'diana-mode  "pls-mode" "DIANA for PL/SQL Browsing Mode" t)
;;;;;(setq auto-mode-alist
;;;;;  (append '(("\\.pls$"  . pls-mode)
;;;;;            ("\\.sql$"  . pls-mode)
;;;;;            ("\\.pld$"  . diana-mode)
;;;;;           ) auto-mode-alist))
;;;;;(setq pls-mode-hook '(lambda () (font-lock-mode 1)))
(autoload 'plsql-mode  "plsql" "PL/SQL Editing Mode" t)
(setq auto-mode-alist
      (append
       '(("\\.\\(p\\(?:k[bg]\\|ls\\)\\|sql\\)\\'" . plsql-mode))
       auto-mode-alist))
(setq plsql-uses-font-lock t)
(add-hook 'pls-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
;; does not work (speedbar-add-supported-extension "pls")
;
; Autoload ispell stuff
;
;(autoload 'ispell-word "ispell"
;          "Check spelling of word at or before point" t)

;(autoload 'ispell-complete-word "ispell"
;          "Complete word at or before point" t)

;(autoload 'ispell-region "ispell"
;          "Check spelling of every word in the region" t)

(autoload 'javascript-mode "javascript-mode" "JavaScript mode" t)
   (setq auto-mode-alist (append '(("\\.js$" . javascript-mode))
                                 auto-mode-alist))

(autoload 'ispell-buffer "ispell"
          "Check spelling of every word in the buffer" t)
;; Xref-Speller configuration part ;;
;;(load "/home/martin/xref/emacs/xrefin.el")
;; end of Xref-Speller configuration part ;;
;
; Autoload the view-process stuff
;
(autoload 'view-processes "view-process-mode"
  "Prints a list with processes in the buffer `view-process-buffer-name'.
   It calls the function `view-process-status' with default switches.
   As the default switches on BSD like systems the value of the variable
   `view-process-status-command-switches-bsd' is used.
   On System V like systems the value of the variable
   `view-process-status-command-switches-system-v' is used.
   IF the optional argument REMOTE-HOST is given, then the command will
   be executed on the REMOTE-HOST. If an prefix arg is given, then the
   function asks for the name of the remote host."
  t)
(autoload 'ps "view-process-mode"
  "Prints a list with processes in the buffer `view-process-buffer-name'.
   COMMAND-SWITCHES is a string with the command switches (ie: -aux).
   IF the optional argument REMOTE-HOST is given, then the command will
   be executed on the REMOTE-HOST. If an prefix arg is given, then the
   function asks for the name of the remote host.
   If USE-LAST-SORTER-AND-FILTER is t, then the last sorter and filter
   commands are used. Otherwise the sorter and filter from the list
   'view-process-sorter-and-filter' are used."
  t)
; psvn.el
(require 'psvn)
(setq svn-status-negate-meaning-of-arg-commands '(svn-status-set-user-mark))
(autoload 'efs "efs" "efs" t)
;;;;;;
;;;;;; Get the hilit19 feature which highlights different areas of sources with
;;;;;; different colours. This module must only be X.
;;;;;;
;;;;;(if (eq window-system 'x)
;;;;;    (progn
;;;;;      (setq hilit-mode-enable-list  '(not text-mode not c-mode) ; Don't highlight in text mode
;;;;;	    hilit-background-mode   'light	; Use colours not shades
;;;;;	    hilit-inhibit-hooks     nil
;;;;;	    hilit-inhibit-rebinding nil
;;;;;	    hilit-auto-highlights t
;;;;;	    hilit-auto-highlight-maxout 500000)
;;;;;      (require 'hilit19)))
;
; +00X002
; html-helper-mode
;
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
;(setq auto-mode-alist (cons '(("\\.html$" . html-helper-mode)
;			      ("\\.shtml$" . html-helper-mode)
;			      ("\\.htm$" . html-helper-mode))
;			    auto-mode-alist))
(setq auto-mode-alist (cons '("\\.html$" . html-helper-mode) auto-mode-alist))
;(add-to-list 'auto-mode-alist '("\\.html$" . html-helper-mode))
(setq html-helper-do-write-file-hooks t) ; update time-stamp in doco
(setq html-helper-build-new-buffer t) ; insert skeleton for new docos
(setq tempo-interactive t)  ; prompt for values of fields
(setq html-helper-basic-offset 2) ; basic indentation for list item
(setq html-helper-item-continue-indent 2) ; additional indents
(setq html-helper-address-string
      "<a href=\"http://devmaster.easysoft.com/~martin/\">Martin J. Evans &lt;martin.evans@easysoft.com&gt;</a>")
; -00X002
; +00X001
;
; Autoload and init for html-mode
;
;(autoload 'hm--html-mode "hm--html-mode" "HTML major mode." t)
;(autoload 'hm--html-minor-mode "hm--html-mode" "HTML minor mode." t)
;
; you use the following for ONLY one html mode:
;
;(or (assoc "\\.html$" auto-mode-alist)
;    (setq auto-mode-alist (cons '("\\.html$" . hm--html-mode)
;				auto-mode-alist)))
;
; and this when more than one html mode:
;
;(setq auto-mode-alist (cons '("\\.html$" . hm--html-mode)
;			    auto-mode-alist))
;(autoload 'tmpl-expand-templates-in-buffer "tmpl-minor-mode"
;  "Expand all templates in the current buffer." t)
;
;(autoload 'html-view-start-mosaic "html-view" "Start Xmosaic." t)
;(autoload 'html-view-view-buffer
;  "html-view"
;  "View the current buffer in Xmosaic."
;  t)
;(autoload 'html-view-view-file
;  "html-view"
;  "View a file in Xmosaic."
;  t)
;(autoload 'html-view-goto-url
;  "html-view"
;  "Goto url in Xmosaic."
;  t)
;(autoload 'html-view-get-display
;  "html-view"
;  "Get the display for Xmosaic (i.e. hostxy:0.0)."
;  t)
;(autoload 'w3-preview-this-buffer "w3" "WWW Previewer" t)
;(autoload 'w3 "w3" "WWW Browser" t)
;(autoload 'w3-open-local "w3" "Open local file for WWW browsing" t)
;(autoload 'w3-fetch "w3" "Open remote file for WWW browsing" t)
;(autoload 'w3-use-hotlist "w3" "Use shortcuts to view WWW docs" t)
;
; Read in the paren module to highlight matching parenthesis.
; Note this only works on systems running X.
;
(load "paren" nil t nil)
(show-paren-mode)
;
; Read in match-it to go to the matching bracket/brace
;
;(autoload 'match-it "match"
;          "Move to the matching bracket to that following dot."
;          'interactive nil)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
(global-set-key "%" 'match-paren)
;
; Automatically unzip/zip files
;
(load "jka-compr" nil t)
;
; XML
;
(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)

(setq auto-mode-alist
      (append '(
		("\\.xml" . xml-mode)
		("\\.dtd" . xml-mode)
		)
	      auto-mode-alist
	      )
      )
;;; Set up and enable syntax coloring.
  ; Create faces  to assign markup categories.
  (make-face 'sgml-doctype-face)
  (make-face 'sgml-pi-face)
  (make-face 'sgml-comment-face)
  (make-face 'sgml-sgml-face)

  (make-face 'sgml-start-tag-face)
  (make-face 'sgml-end-tag-face)
  (make-face 'sgml-entity-face)

  ; Assign attributes to faces. Background of white assumed.

  (set-face-foreground 'sgml-doctype-face "blue1")
  (set-face-foreground 'sgml-sgml-face "cyan1")
  (set-face-foreground 'sgml-pi-face "magenta")
  (set-face-foreground 'sgml-comment-face "purple")
  (set-face-foreground 'sgml-start-tag-face "Red")
  (set-face-foreground 'sgml-end-tag-face "Red")
  (set-face-foreground 'sgml-entity-face "Blue")

  ; Assign faces to markup categories.
  (setq sgml-markup-faces
        '((doctype        . sgml-doctype-face)
          (pi             . sgml-pi-face)
          (comment        . sgml-comment-face)
          (sgml   . sgml-sgml-face)
          (comment        . sgml-comment-face)
          (start-tag      . sgml-start-tag-face)
          (end-tag        . sgml-end-tag-face)
          (entity . sgml-entity-face)))


  ; PSGML - enable face settings
  (setq sgml-set-face t)

  ;(setq sgml-catalog-file "/home/martin/catalog")

  ; Auto-activate parsing the DTD when a document is loaded.
  ; If this isn't enabled, syntax coloring won't take affect until
  ; you manually invoke "DTD->Parse DTD"
  (setq sgml-auto-activate-dtd t)
  (setq sgml-validate-command "cmllint --noout --valid %s %s")
;
; Now read in the cc-mode and define the extensions used to identify C and C++
; modules. ".cc" or ".C" for C++ and ".c" for C.
;
(autoload 'c++-mode "cc-mode" "C++ Editing Mode" t)
(autoload 'c-mode "cc-mode" "C Editing Mode" t)
(autoload 'objc-mode "cc-mode" "Objective-C Editing Mode" t)
(setq auto-mode-alist
      (append '(("\\.C$"  . c++-mode)
                ("\\.cc$" . c++-mode)
                ("\\.hh$" . c++-mode)
                ("\\.c$"  . c-mode)
                ("\\.h$"  . c-mode)
		("\\.m$"  . objc-mode))
              auto-mode-alist))
;
; Load in the hide ifdef stuff
;
(autoload 'hide-ifdef-mode "hideif" "hideifdefmode" t)
;
; display time and machine load level in status line.
;
(display-time)
;
; Ensure emacs makes backup files with version control but tell it only to
; keep the two oldest and the two newest.
;
(setq make-backup-files t)
(setq version-control t)
(setq kept-old-versions 1)
(setq kept-new-versions 1)
;
; +00X004
;
; I don't wnat to have to type "yes" or "no"
;
(fset 'yes-or-no-p 'y-or-n-p)
;
; -00X004
;
; Truncate lines at the terminal width. This set because lines in C source
; may contain 80 columns + <CR>. emacs classes these lines as 81 columns and
; wraps them but setting truncate-lines stops this.
;
;(setq-default truncate-lines t)
;
; Hide deeply indented lines
;
;(setq-default selective-display 20)
;
; Allow Meta-; to add a comment to the end of a line a column 40.
; Could add a hook to auto-fill-mode to define the set-fill-prefix
; and set-fill-column.
;
;(setq set-comment-column 48)
(setq fill-column 74)
; Only indent line with TAB key if in whitespace at start of line.
;
(setq c-tab-always-indent nil)
;
;(setq tab-stop-list (list 4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
;
; Define a function to swap keys.
; (used to swap ctrl/s and ctrl/q for vtnnn
;
(defun swap-keys (key1 key2)
  "Swap keys KEY1 and KEY2 using map-key."
  (map-key key1 key2)
  (map-key key2 key1))
;
; Define a function to map one key to another.
; (used to swap ctrl/s and ctrl/q for vtnnn
;
(defun map-key (from to)
  "Make key FROM behave as though key TO was typed instead."
  (setq keyboard-translate-table
	(concat keyboard-translate-table
		(let* ((i (length keyboard-translate-table))
		       (j from)
		       (k i)
		       (str (make-string (max 0 (- j (1- i))) ?X)))
		  (while (<= k j)
		    (aset str (- k i) k)
		    (setq k (1+ k)))
		  str)))
  (aset keyboard-translate-table from to)
  (let ((i (1- (length keyboard-translate-table))))
    (while (and (>= i 0) (eq (aref keyboard-translate-table i) i))
      (setq i (1- i)))
    (setq keyboard-translate-table
	  (if (eq i -1)
	      nil
	    (substring keyboard-translate-table 0 (1+ i))))))
;
; Move CTRL/S to CTRL/\ as CTRL/S is stall on vt terminals.
; Move CTRL/Q to CTRL/^ as CTRL/Q is resume on vt terminals.
;
(swap-keys ?\C-s ?\C-\\)
(swap-keys ?\C-q ?\C-^)

;
; Set variable to show hide-ifdefs should be called when hide-ifdef mode entered
; Add a hook to be called when hide-ifdef-mode is entered. This defines two
; lists, one for vms and one for unix which contain the macros to be defined
; for vms and unix. By default the unix list is used when hide-ifdef-mode is
; entered.
;
(setq hide-ifdef-initially t)
(add-hook 'hide-ifdef-mode-hook
	  (function (lambda()
		      (if (not hide-ifdef-define-alist)
			  (setq hide-ifdef-define-alist
				'((vms vms VMS alpha ALPHA)
				  (unix unix UNIX hp HP sun SUN ibm IBM ncr NCR)
				  (hp unix UNIX hp HP)
				  (sun unix UNIX sun SUN)
				  (ibm unix UNIX ibm IBM)
				  (ncr unix UNIX ncr NCR)
				  )))
		      (hide-ifdef-use-define-alist 'unix) ; use unix by default
		      )))
;
; Set up CC-mode
;
(defconst mje-c-style
  '("MJE"
    (c-electric-pound-behavior  . (alignleft))
    (c-tab-always-indent        . nil)  ; TAB only re-indents line in white-space
    (c-comment-only-line-offset . 0) ; Comments at left margin
    (c-block-comments-indent-p  . nil)  ; Block comment style 2
    (c-hanging-comment-ender-p  . nil)  ; comment terminator on its own
    (c-hanging-colons-alist     . ((case-label after) ; NL after case label
                                   (label after))) ; NL after label
    (c-hanging-braces-alist     . ((block-open before))) ;NL before block brace
    (c-cleanup-list             . (empty-defun-braces
                                   defun-close-semi
                                   list-close-comma))
    (c-offsets-alist            . ((arglist-close        . c-lineup-arglist)
                                   (case-label           . 2)
                                   (statement-case-intro . 2)
                                   (substatement-open    . 0)
                                   (block-open           . 0))))
  "MJE C programming style")

(defconst mje-c-style2
  '("MJE"
    (c-electric-pound-behavior  . (alignleft))
    (c-tab-always-indent        . nil)  ; TAB only re-indents line in white-space
    (c-comment-only-line-offset . 0) ; Comments at left margin
    (c-block-comments-indent-p  . nil)  ; Block comment style 2
    (c-hanging-comment-ender-p  . nil)  ; comment terminator on its own
    (c-hanging-colons-alist     . ((case-label after) ; NL after case label
                                   (label after))) ; NL after label
    (c-hanging-braces-alist     . ((block-open after)
				   (inline-open after)
				   (defun-open after)
				   (substatement-open after))) ;NL before block brace
    (c-cleanup-list             . (empty-defun-braces
                                   defun-close-semi
                                   list-close-comma))
    (c-offsets-alist            . ((arglist-close        . c-lineup-arglist)
                                   (case-label           . 2)
                                   (statement-case-intro . 2)
                                   (substatement-open    . 0)
                                   (block-open           . 0))))
  "MJE C programming style")
(defun mje-c-mode-common-hook ()
  (let ((mje-style "MJE"))
    (or (assoc mje-style c-style-alist)
        (setq c-style-alist (cons mje-c-style2 c-style-alist)))
    (c-set-style mje-style))
;
; Some customisations not defined in mje style
;
  (c-set-offset 'member-init-intro (* 2 c-basic-offset))
  (c-set-offset 'case-label (/ c-basic-offset 2))
  (c-set-offset 'statement-case-intro (/ c-basic-offset 2))
  (setq tab-width 4			; tab size when displaying tabs
        indent-tabs-mode nil)		; do not insert tabs in indentation
  (c-toggle-auto-hungry-state 1)
  (define-key c-mode-map "\C-m" 'newline-and-indent)
  (define-key c-mode-map "\C-c\C-c" 'compile)
  (setq comment-column 48)		; Add comments at column 56
  (setq c-recognize-knr-p nil)		; DO NOT look for k & r constructs 19.27.1
  (setq c-strict-syntax-p t))		; Error if symbol not in alist 19.27.1
(add-hook 'c-mode-common-hook 'mje-c-mode-common-hook)
;
; Set up C mode.
;   handling of text formatting
;
;(add-hook 'c-mode-hook
;	  (function (lambda ()
;		      (setq c-indent-level 4
;			    c-auto-newline t
;			    c-argdecl-indent 0
;			    c-label-offset -4
;			    c-continued-brace-offset 2
;			    c-continued-statement-indent 0
;			    c-brace-offset -4
;			    comment-column 48))))
(global-set-key "\C-x%" 'match-it)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\C-xz" 'view-processes)
(set-time-zone-rule "GB")
(load "gnus")
(setq gnus-select-method '(nntp "news.easysoft.com"))
(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(add-log-time-format (quote current-time-string))
 '(auto-insert t)
 '(auto-insert-alist (quote ((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") (upcase (concat (file-name-nondirectory (substring buffer-file-name 0 (match-beginning 0))) "_" (substring buffer-file-name (1+ (match-beginning 0))))) "#ifndef " str n "#define " str "

" _ "

#endif") (("\\.\\([Cc]\\|cc\\|cpp\\)\\'" . "C / C++ program") . "insert.c") ("[Mm]akefile\\'" . "makefile.inc") (html-mode lambda nil (sgml-tag "html")) (plain-tex-mode . "tex-insert.tex") (bibtex-mode . "tex-insert.tex") (latex-mode "options, RET: " "\\documentstyle[" str & 93 | -1 123 (read-string "class: ") "}
" ("package, %s: " "\\usepackage[" (read-string "options, RET: ") & 93 | -1 123 str "}
") _ "
\\begin{document}
" _ "
\\end{document}") (("/bin/.*[^/]\\'" . "Shell-Script mode magic number") lambda nil (if (eq major-mode default-major-mode) (sh-mode))) (ada-mode . ada-header) (("\\.el\\'" . "Emacs Lisp header") "Short description: " ";;; " (file-name-nondirectory (buffer-file-name)) " --- " str "

;; Copyright (C) " (substring (current-time-string) -4) " by " (getenv "ORGANIZATION") | "Free Software Foundation, Inc." "

;; Author: " (user-full-name) (quote (if (search-backward "&" (save-excursion (beginning-of-line 1) (point)) t) (replace-match (capitalize (user-login-name)) t t))) (quote (end-of-line 1)) " <" (user-login-name) 64 (system-name) ">
;; Keywords: " (quote (require (quote finder))) (quote (setq v1 (mapcar (lambda (x) (list (symbol-name (car x)))) finder-known-keywords) v2 (mapconcat (lambda (x) (format "%10.0s:  %s" (car x) (cdr x))) finder-known-keywords "
"))) ((let ((minibuffer-help-form v2)) (completing-read "Keyword, C-h: " v1 nil t)) str ", ") & -2 "

;;; " (file-name-nondirectory (buffer-file-name)) " ends here"))))
 '(auto-insert-query t)
 '(change-log-default-name "/root/sysman.log")
 '(sgml-validate-command "xmllint --noout --valid %s %s")
 '(show-trailing-whitespace t)
 '(display-time-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(svn-status-default-diff-arguments nil)
 '(svn-status-ediff-delete-temporary-files t)
 '(svn-status-hide-unknown t)
 '(tool-bar-mode nil))
;
;
;
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "wheat" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "FreeMono")))))

;
; Enable saving of this emacs session
(load "desktop")
(desktop-load-default)
(desktop-read)

; byte-compile-file
