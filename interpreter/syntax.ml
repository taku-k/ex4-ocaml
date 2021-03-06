(* ML interpreter / type reconstruction *)
type id = string

type binOp = Plus | Mult | Lt | LogAnd | LogOr

type exp =
    Var of id
  | ILit of int
  | BLit of bool
  | BinOp of binOp * exp * exp
  | IfExp of exp * exp * exp
  | LetExp of id * exp * exp
  | ErrorExp of string
  | FunExp of id * exp
  | AppExp of exp * exp
  | LetRecExp of id * id * exp * exp
  | InfixExp of binOp

type program = 
    Exp of exp
  | Decl of id * exp
  | RecDecl of id * id * exp
