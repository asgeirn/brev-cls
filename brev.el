;;; brev.el - Special code for brev style.

;; $Id: brev.el,v 1.3 2004/05/01 15:58:42 pere Exp $

;;    This program is free software; you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation; either version 2 of the License, or
;;    (at your option) any later version.
;;
;;    This program is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;
;;    You should have received a copy of the GNU General Public License
;;    along with this program; if not, write to the Free Software
;;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

;;; Code:

(require 'cl)

; Autoloadings
(autoload 'bbdb-completing-read-record "bbdb-com" t nil)
(autoload 'bbdb-record-name "bbdb" nil nil)
(autoload 'bbdb-record-company "bbdb" nil t)
(autoload 'bbdb-record-addresses "bbdb" nil t)
(autoload 'tomorrow "ambolt" t nil)

(defconst LaTeX-letter-magic "*"
  "The \`magic\' character being looked for in address locations.")

(defconst LaTeX-letter-empty-line 
  (concat "~" TeX-esc TeX-esc)
  "An \`empty\' line of text.")

;; You may want to define these in ~/.emacs

(defcustom LaTeX-letter-attn "Attn.:~"
  "*Attention label when sending nonpersonal letters to a company"
  :type '(string))

(defcustom LaTeX-letter-sender-address nil
  "*Initial value when prompting for a sender address in the letter style."
  :type '(string))

(defcustom LaTeX-letter-closing nil
  "*Initial value when prompting for \\closing in the letter style."
  :type '(string))

(defcustom LaTeX-letter-location nil
  "*Initial value when prompting for \\location in the letter style."
  :type '(string))

(defvar LaTeX-letter-point (point-min)
  "*Initial point position when creating a new letter.")

;(defcustom LaTeX-letter-telephone nil
;  "*Initial value when prompting for \\telephone in the letter style.")

(defcustom LaTeX-use-bbdb nil
  "*If non-nil, the Inisidious Big Brother Database is used to find and
insert the recipient's address."
  :type '(boolean))

(TeX-add-style-hook "brev"
 (function
  (lambda ()
    (setq LaTeX-default-environment "letter")
    (LaTeX-add-environments
     '("letter" LaTeX-env-recipient))
    (TeX-add-symbols
     '("name" "Sender") 
     '("address" "Sender address")
     '("signature" "Signature")
     '("location" "Location")
     '("telephone" "Telephone")
     '("cc" "Copy recipients")
     '("encl" "Enclosures")
     '("yourref" "Your ref.")
     '("ourref" "Our ref.")
     '("LetterDate" (TeX-arg-eval read-input "Date: " (LaTeX-today)))
     '("date" "Date text")
     '("opening" "Opening")
     '("closing" "Closing")))))

(defun LaTeX-env-recipient (environment)
  "Insert ENVIRONMENT and prompt for recipient and address."
  (let ((sender (read-input "Sender: " (user-full-name)))
	(sender-address (read-input "Sender address: "
				    LaTeX-letter-sender-address))
        (recipient (LaTeX-bbdb-recipient))
        (address nil)
	(signature nil) ;(read-input "Signature: "))
        (location (read-input "Location: " LaTeX-letter-location))
        (telephone nil) ;(read-input "Telephone: " LaTeX-letter-telephone))
	(opening (read-input "Opening: "))
	(closing (read-input "Closing: "
                             LaTeX-letter-closing))
	(date (read-input "Date: " (LaTeX-today))))

    (if (not (zerop (length sender)))
        (progn
          (insert TeX-esc "name" TeX-grop sender TeX-grcl)
          (newline-and-indent)))
    (if (not (zerop (length sender-address)))
	(progn
	  (setq LaTeX-letter-sender-address sender-address)
	  (insert TeX-esc "address" TeX-grop sender-address TeX-grcl)
	  (newline-and-indent)))
    (if (not (zerop (length signature)))
	(progn
	  (insert TeX-esc "signature" TeX-grop signature TeX-grcl)
	  (newline-and-indent)))
    (if (not (zerop (length location)))
	(progn
	  (insert TeX-esc "location" TeX-grop location TeX-grcl)
	  (newline-and-indent)))
    (if (not (zerop (length telephone)))
	(progn
	  (insert TeX-esc "telephone" TeX-grop telephone TeX-grcl)
	  (newline-and-indent)))
    (if (not (zerop (length date)))
	(progn
	  (insert TeX-esc "LetterDate" TeX-grop date TeX-grcl)
	  (newline-and-indent)))
    (newline-and-indent)

    (let ((indentation (current-column))
          (auto-fill-function nil))
      (LaTeX-insert-environment
       environment
       (concat TeX-grop recipient
	       (if (not (zerop (length address)))
		   (concat
		    (if (not (zerop (length recipient)))
			(concat " " TeX-esc TeX-esc " "))
		    address))
	       TeX-grcl))
      (save-excursion			; Fix indentation of address
	(if (search-backward TeX-grcl nil 'move)
	    (let ((addr-end (point-marker)))
	      (if (search-backward TeX-grop nil 'move)
                  (progn 
                    (forward-char)
                    (let ((addr-column (current-column)))
                      (insert TeX-esc "large")
                      (newline)
                      (indent-to addr-column)
                      (while (search-forward
                              (concat TeX-esc TeX-esc)
                              (marker-position addr-end) 'move)
                        (progn
                          (newline)
                          (indent-to addr-column)))))))))
      (insert "\n")
      (indent-to indentation))
    (if (not (zerop (length opening)))
        (insert TeX-esc "opening" TeX-grop
                TeX-esc "textbf" TeX-grop
                opening
                TeX-grcl TeX-grcl "\n"))

    (indent-relative-maybe)
    (save-excursion
      (if (not (zerop (length closing)))
          (insert "\n" TeX-esc "closing"
                  TeX-grop
                  closing
                  TeX-grcl "\n"))
      (indent-relative-maybe))))

(defun LaTeX-today nil
  "Return a string representing todays date according to flavor."
  (interactive)
  (format-time-string "%Y-%m-%d" (current-time)))

(defun LaTeX-bbdb-recipient nil
  "Reads a recipient from either the Inisidious Big Brother Database
or the user and returns name and address."
  (save-window-excursion
    (let* (;(bbdb-completion-type 'name)
           (record (and LaTeX-use-bbdb
                        (bbdb-completing-read-record "Recipient (BBDB): ")))
           (foo (and record (bbdb-display-records-1 record)))
           (record (and record
                        (car record)))
           (name (if record
                     (bbdb-record-name record)
                   (read-input "Recipient: ")))
           (company (and record
                         (bbdb-record-company record)))
           (address (if (null record)
                        ;; Allow the user to type an address in the
                        ;; minibuffer.  This uses BBDB's own address
                        ;; editing capabilites.
                        (let ((addr (make-vector bbdb-address-length nil)))
                          (bbdb-record-edit-address addr "Brev")
                          addr)
                      (let* ((addresses (bbdb-record-addresses record))
                             (addr-alist (and (listp addresses)
                                              (> (length addresses) 0)
                                              (mapcar (lambda (l) 
                                                        (append (list (bbdb-address-location l)) l)) 
                                                      addresses)))
                             (completion-ignore-case t)
                             (addr (and addr-alist
                                        (completing-read "Recipient address (BBDB): " 
                                                         addr-alist 
                                                         nil 
                                                         t 
                                                         (try-completion LaTeX-letter-magic addr-alist)))))
                        (if addr
                            (cdr (assoc addr addr-alist))
                          (setq addr (make-vector bbdb-address-length nil))
                          (bbdb-record-edit-address addr)
                          addr)))))
      (mapconcat 'identity
                 (append
                  (list (cond 
                         ((and company 
                               name
                               (bbdb-address-location address)
                               (not (equal (substring (bbdb-address-location address) -1) LaTeX-letter-magic)))
                          (if (y-or-n-p "Personal letter? ")
                              (concat name TeX-esc TeX-esc company)
                            (concat company TeX-esc TeX-esc LaTeX-letter-attn name)))
                         (name name)
                         (t company)))
                  (bbdb-address-streets address)
                  (list (concat TeX-esc " ")
                        (if (> (length (bbdb-address-zip-string address)) 0)
                            (concat (bbdb-address-zip-string address) 
                                    TeX-esc " " TeX-esc " "
                                    (upcase (bbdb-address-city address)))
                          (message "No zip.")
                          (upcase (bbdb-address-city address)))))
                 (concat TeX-esc TeX-esc)))))

;;; brev.el ends here
