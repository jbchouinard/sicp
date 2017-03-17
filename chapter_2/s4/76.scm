; SICP Exercise 2.76

; In a system with generic operations, the implementation of each operation
; must be modified each time a type is added. However, adding a new operation
; only requires coding that operation; the others are untouched.

; In a message passing system, the opposite is true. A new operation requires
; modifying all the types that implement it. Adding a new type doesn't require
; touching any other type.

; In the data-directed style, packages can be organized in any way desired.
; A package could implement multiple operations for a type, of a single
; operation for multiple types, or something in between. The only requirement
; is that the package registers its operations in the ops table.
