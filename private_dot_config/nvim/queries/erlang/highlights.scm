;; Copyright (c) Facebook, Inc. and its affiliates.
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;     http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.
;; ---------------------------------------------------------------------

;; Based initially on the contents of https://github.com/WhatsApp/tree-sitter-erlang/issues/2 by @Wilfred
;; and https://github.com/the-mikedavis/tree-sitter-erlang/blob/main/queries/highlights.scm
;;
;; The tests are also based on those in
;; https://github.com/the-mikedavis/tree-sitter-erlang/tree/main/test/highlight
;;

;; Last match wins in this file.
;; As of https://github.com/tree-sitter/tree-sitter/blob/master/CHANGELOG.md#breaking-1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Primitive types
(string) @string
(char) @constant
(integer) @number
(float) @number.float
(var) @variable
(atom) @constant

;;; Comments
((var) @comment.discard
 (#match? @comment.discard "^_"))

(dotdotdot) @comment.discard
(comment) @comment @spell

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^[%%][%%]"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Functions
(fa fun: (atom) @function)
(type_name name: (atom) @function)
; (call expr: (atom) @function)

; expr_function_call
(call
  expr: [
    (atom)
    (remote)
    (var)
  ] @function)

(call
  (atom) @keyword.exception
  (#any-of? @keyword.exception "error" "throw" "exit"))

; Parenthesized expression: (SomeFunc)(), only highlight the parens
(call
  expr: (paren_expr
    "(" @function.call
    ")" @function.call))


(function_clause name: (atom) @function)
(external_fun) @function.call
(internal_fun fun: (atom) @function.call)

;; This is a fudge, we should check that the operator is '/'
;; But our grammar does not (currently) provide it
(binary_op_expr lhs: (atom) @function rhs: (integer))

;; Others
(remote_module module: (atom) @type)
(remote fun: (atom) @function)
(macro_call_expr name: (var) @constant)
(macro_call_expr name: (var) @keyword.directive args: (_) )
(macro_call_expr name: (atom) @keyword.directive)
(record_field_name name: (atom) @property)
(record_name name: (atom) @type)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Attributes

;; module attribute
(module_attribute
  name: (atom) @type)

;; behaviour
(behaviour_attribute name: (atom) @type)

;; export

;; Import attribute
(import_attribute
    module: (atom) @module)

;; export_type

;; optional_callbacks

;; compile
(compile_options_attribute
    options: (tuple
      expr: (atom)
      expr: (list
        exprs: (binary_op_expr
          lhs: (atom)
          rhs: (integer)))))

;; file attribute

;; record
(record_decl name: (atom) @type)
(record_decl name: (macro_call_expr name: (var) @constant))
(record_field name: (atom) @property)

;; type alias

;; opaque

;; Spec attribute
(spec fun: (atom) @function)
(spec
  module: (module name: (atom) @module)
  fun: (atom) @function)

;; callback
(callback fun: (atom) @function)

;; wild attribute
(wild_attribute name: (attr_name name: (atom) @keyword))

;; fun decl

;; include/include_lib

;; ifdef/ifndef
(pp_ifdef name: (_) @keyword.directive)
(pp_ifndef name: (_) @keyword.directive)

;; define
(pp_define
    lhs: (macro_lhs
      name: (var) @constant))
(pp_define
    lhs: (macro_lhs
      name: (_) @keyword.directive
      args: (var_args args: (var))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reserved words
[ "and"
  "band"
  "behavior"
  "behaviour"
  "bnot"
  "bor"
  "bsl"
  "bsr"
  "bxor"
  "callback"
  "compile"
  "define"
  "div"
  "elif"
  "endif"
  "export"
  "export_type"
  "file"
  "fun"
  "if"
  "ifdef"
  "ifndef"
  "import"
  "include"
  "include_lib"
  "module"
  "opaque"
  "optional_callbacks"
  "or"
  "receive"
  "record"
  "rem"
  "spec"
  "type"
  "undef"
  "unit"
  "xor"] @keyword

; conditional
[
  "receive"
  "if"
  "case"
  "of"
  "when"
  "after"
  "begin"
  "end"
  "maybe"
  "else"
] @keyword.conditional

[
  "catch"
  "try"
] @keyword.exception


["andalso" "orelse"] @keyword.operator

;; Punctuation
["," "." ";"] @punctuation.delimiter
["(" ")" "{" "}" "[" "]" "<<" ">>"] @punctuation.bracket

;; Operators
["!"
 "->"
 "<-"
 "#"
 "::"
 "|"
 "?="
 ":"
 "="
 "||"

 "+"
 "-"
 "bnot"
 "not"

 "/"
 "*"
 "div"
 "rem"
 "band"
 "and"

 "+"
 "-"
 "bor"
 "bxor"
 "bsl"
 "bsr"
 "or"
 "xor"

 "++"
 "--"

 "=="
 "/="
 "=<"
 "<"
 ">="
 ">"
 "=:="
 "=/="
 ] @operator
