(and pedz-init-debug (message "begin resize"))
(defun workarea-left ( monitor )
  "MONITOR is an entry from `display-monitor-attributes-list' The
left entry (1st value) of the 'workarea' is returned"
  (nth 1 (assoc 'workarea monitor)))

(defun workarea-top ( monitor )
  "MONITOR is an entry from `display-monitor-attributes-list' The
top entry (2nd value) of the 'workarea' is returned"
  (nth 2 (assoc 'workarea monitor)))

(defun workarea-width ( monitor )
  "MONITOR is an entry from `display-monitor-attributes-list' The
width entry (3rd value) of the 'workarea' is returned"
  (nth 3 (assoc 'workarea monitor)))

(defun workarea-height ( monitor )
  "MONITOR is an entry from `display-monitor-attributes-list' The
height entry (4th value) of the 'workarea' is returned"
  (nth 4 (assoc 'workarea monitor)))

(defun monitor-with-largest-height-helper ( a b )
  "Compares the height of the workarea of two monitor entries such
as those contained in the output of
`display-monitor-attributes-list'"
  (let* ((a-height (workarea-height a))
         (b-height (workarea-height b)))
    (if (> a-height b-height)
        a
      b)))

(defun monitor-with-largest-height ()
  "Returns the monitor entry from `display-monitor-attributes-list'
with the largest 'workarea' height"
    (cl-reduce #'monitor-with-largest-height-helper
                                     (display-monitor-attributes-list)))

(defun usable-height ( monitor )
  "Returns the usable height in lines of the MONITOR entry"
  (/ (- (workarea-height monitor)
        (- (frame-outer-height)
           (frame-inner-height)))
     (frame-char-height)))

(defun usable-width ( monitor )
  "Returns the usable width in character columns of the MONITOR
entry"
  (/ (- (workarea-width monitor)
        (frame-fringe-width)
        (frame-scroll-bar-width))
     (frame-char-width)))

(defun my-position-frame ()
  "Sets the current frame to the full hight of the largest (by
height) monitor currently connected.  Sets the width to 1/3rd of
that monitor's width.  And positions the frame at the top center
of that monitor's screen."
  (interactive)
  (let* ((monitor (monitor-with-largest-height))
         (width (max (/ (usable-width monitor) 2) 80))
         (pixel-width (* width (frame-char-width)))
         (pixel-left (/ (- (workarea-width monitor) pixel-width) 2))
         (height (usable-height monitor))
         (left (+ (workarea-left monitor) pixel-left))
         (top (workarea-top monitor)))
    (message "left:%d top:%d width:%d height:%d" left top width height)
    (set-frame-position nil left top)
    (set-frame-size nil width height)))

(provide 'resize)
(and pedz-init-debug (message "end resize"))
