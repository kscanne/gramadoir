;;; gramadoir.el --- Interface to An Gramadóir

;; $Id$

;; Copyright (C) 2003  Free Software Foundation, Inc.

;; Author: Martin Gregory <Martin.Gregory@eur.sas.com>
;; Keywords: hypermedia, unix

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;; This package provides an interface to the Irish language grammar
;; checking program An Gramadóir

;;; Code:

(defvar gramadoir-program-path "/usr/local/bin/gr"
"Location of the executable for An Gramadóir"
)

(defvar gramadoir-program-options "" ;"--xml"
"options for the executable for An Gramadóir")

(defvar gramadoir-results-alist ""
"alist containing list of lines with errors")

(defvar gramadoir-xml-buffer ""
"Name of buffer containing the xml output from An Gramadóir")

(defvar gramadoir-display-buffer "*Gramadoir Output*"
"Name of buffer containing human readable output of An Gramadóir")

(defvar gramadoir-current-file ""
"File containing the current error")

(defvar gramadoir-current-line 0
"Line in the current file on which the current error occurs")

(defun gramadoir-check-region (start end)
"This function runs the grammar checking program An Gramadóir on the current 
region, if there is one. The function can also be called using 
	(gramadoir-check-region (point) (mark))
from within a lisp program. The xml output from An Gramadóir is sent to a 
temporary buffer whence it can be parsed.
"
(interactive "r") ; default to region for start and end if interactive

(call-process-region (point) (mark)	; the region
		     gramadoir-program-path 
		     nil	; keep output
		     buffer	; write to buffer
		     nil	; dont show it until finished
		     gramadoir-program-options)
;; might want to call (setq output (shell-command-to-string command))
;; calls:
;gramadoir-parse-results (buffer)
)

(defun gramadoir-check-files (gramadoir-file-spec)
  "This function runs the grammar checking program An Gramadóir on a list of 
files.
"
  (interactive "sFiles: ")
  (if (get-buffer gramadoir-display-buffer)
      (progn
	(set-buffer gramadoir-display-buffer)
	(erase-buffer)
	))
  (setq gr-cmd `(call-process gramadoir-program-path 
			      nil	; no standard input
			      gramadoir-display-buffer	; write to buffer
			      nil	; dont show it until finished
			      ,@(split-string gramadoir-file-spec " ")))
  (eval gr-cmd)

  ;; calls:
  ;;gramadoir-parse-results (buffer)
  ;; display the results in the lower window.
  (set-buffer gramadoir-display-buffer)
  (goto-char (point-min))
  (display-buffer gramadoir-display-buffer t)
  )

(defun gramadoir-format-message (text)
"convert an error message code (xml tag) into a human-readable form")

(defun gramadoir-get-location (text)
"determine the exact location of the erroneous text so that it can be 
highlighted in the display")

(defun gramadoir-get-substitution (text)
"If An Gramadóir suggests an alternative, save it keyed on the error location 
so it can be presented to the user for possible substitution")

(defun gramadoir-parse-results (buffer)
"Parse the results of the call to An Gramadóir"
;; calls:
; (gramadoir-format-message)
; (gramadoir-get-location)
; (gramadoir-get-substitution)
)

(defun gramadoir-next-message ()
  "Jump to next message"
  (interactive)
  (set-buffer gramadoir-display-buffer)
  (if (get-buffer-window gramadoir-display-buffer)
      (delete-window (get-buffer-window gramadoir-display-buffer)))
  ;; determine line number of next message
  ;(message "Before re-search: in %s at %d" (current-buffer) (point))
  (re-search-forward "^\\([0-9]*\\):")
  (setq gramadoir-current-line (string-to-number (match-string 1)))

  ;(message "Before excursion: in %s at %d" (current-buffer) (point))

  ;; determine which file is the message in 
  (setq gramadoir-current-file 
	(save-excursion 
	  (end-of-line) ; in case we are located on a file name line
	  (re-search-backward "^Currently checking ")
	  (forward-word 2)
          (buffer-substring (+ 1 (point))
                            (save-excursion (end-of-line) (point)))))

  ;(message "After excursion: in %s at %d" (current-buffer) (point))
  (gramadoir-goto-message gramadoir-current-file gramadoir-current-line)
  )

(defun gramadoir-goto-message (gramadoir-current-file gramadoir-current-line)
  "Jump to selected message"
  (interactive)
  ;; load the file if it is not already loaded
  ;(message "ggm: %s %s %s" gramadoir-current-file gramadoir-current-line
  ;	   (get-file-buffer gramadoir-current-file))
  (if (get-file-buffer gramadoir-current-file) 
      nil
    (find-file-other-window gramadoir-current-file)
    )
  (set-buffer (get-file-buffer gramadoir-current-file))
  (goto-line gramadoir-current-line)
  ;(message "ggm: %s %d " gramadoir-current-file (point))

  (switch-to-buffer (get-file-buffer gramadoir-current-file))
  (display-buffer gramadoir-display-buffer)
)

(defun gramadoir-display-results ()
"Major mode for display of parsed, formatted results."
(interactive)
; calls
; gramadoir-next-message
; gramadoir-goto-message
)
(provide 'gramadoir)
;;; gramadoir.el ends here
