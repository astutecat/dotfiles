
((atom) @constant (#set! "priority" "90"))
(var) @variable

(char) @character
(integer) @number
(float) @float

(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[%%][%%]"))

;; keyword
[
  "fun"
  "div"
  "begin"
] @keyword

;; bracket
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
  "#"
] @punctuation.bracket

;;; Comparisons
[
  "=="
  "=:="
  "=/="
  "=<"
  ">="
  "<"
  ">"
  "div"
  "rem"
  "andalso"
  "orelse"
] @operator ;; .comparison

;;; operator
[
  ","
  "."
  ";"
  ":"
  "::"
  ":="
  "!"
  ;"-"
  "--"
  "+"
  "++"
  "*"
  "/"
  "="
  "<-"
  "->"
  "=>"
  "|"
  "||"
  "?="
] @operator

[
  ","
  "."
  ";"
] @punctuation.delimiter

;; conditional
[
  "receive"
  "if"
  "case"
  "of"
  "when"
  "after"
  "end"
  "maybe"
  "else"
] @conditional

[
  "catch"
  "try"
] @exception

((atom) @boolean (#any-of? @boolean "true" "false"))


;; Preprocessor
(pp_define
  lhs: _ @constant.macro (#set! "priority" 101)
  replacement: (_) @constant
)

(_preprocessor_directive) @preproc (#set! "priority" 99)

;; Attributes
(pp_include) @include
(pp_include_lib) @include
(export_attribute) @include
(export_type_attribute) @type.definition
(export_type_attribute types: (fa fun: _ @type (#set! "priority" 101)))
(module_attribute (atom) @constant) @namespace
(behaviour_attribute (atom) @constant) @include
(wild_attribute name: (attr_name name: _ @attribute)) @attribute

;; Records
(record_expr) @type
(record_field_expr _ @field) @type
(record_field_name _ @field) @type
(record_name "#" @type name: _ @type) @type
(record_decl name: _ @type) @type.definition
(record_field name: _ @field)
(record_field name: _ @field ty: _ @type)

;; Type alias
(type_alias name: _ @type) @type.definition
(spec) @type.definition

[(string) (binary)] @string

;;; expr_function_call
(call expr: [(atom) (remote) (var)] @function)
(call (atom) @exception (#any-of? @exception "error" "throw" "exit"))

;;; Parenthesized expression: (SomeFunc)(), only highlight the parens
(call
  expr: (paren_expr "(" @function.call ")" @function.call)
)

;;; function
(external_fun) @function.call
(internal_fun fun: (atom) @function.call)
(function_clause name: (atom) @function)
(fa fun: (atom) @function)

;; Macros

(macro_call_expr name: (var) @keyword.directive args: (_) )
(macro_call_expr name: (var) @constant)
(macro_call_expr name: (atom) @keyword.directive)

