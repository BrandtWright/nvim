;; extends

;; Conceal bullet points
([(list_marker_plus) (list_marker_star)]
  @punctuation.special
  (#offset! @punctuation.special 0 0 0 -1)
  (#set! conceal "●"))
([(list_marker_plus) (list_marker_star)]
  @punctuation.special
  (#any-of? @punctuation.special "+" "*")
  (#set! conceal "●"))
