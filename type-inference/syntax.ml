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

type tyvar = int

type ty =
    TyInt
  | TyBool
  | TyVar of tyvar
  | TyFun of ty * ty

let rec pp_ty_string ty =
  let memo = ref [] in
  let get_num v =
    let rec body l cnt =
      match l with
        [] -> memo := !memo @ [v]; cnt
      | hd :: tl -> if v = hd then cnt else body tl (cnt + 1)
  in body !memo 0 in
  let rec inner_print_ty = function
    TyInt -> "int"
  | TyBool -> "bool"
  | TyVar (var) -> "'" ^ (Char.escaped (char_of_int ((int_of_char 'a') + (get_num var))))
  | TyFun (ty1, ty2) -> 
      let s1 = inner_print_ty ty1 in
      let s2 = inner_print_ty ty2 in
      (match ty1 with
        TyFun (_, _) ->  "(" ^ s1 ^ ") -> " ^ s2
      | _ -> s1 ^ " -> " ^ s2)
  in inner_print_ty ty

let pp_ty ty = print_string (pp_ty_string ty)

let fresh_tyvar =
  let counter = ref 0 in
  let body () =
    let v = !counter in
      counter := v + 1; v
  in body

let rec freevar_ty ty = 
  (match ty with
      TyVar (tyvar) -> MySet.singleton tyvar
    | TyFun (ty1, ty2) -> MySet.union (freevar_ty ty1) (freevar_ty ty2)
    | _ -> MySet.empty)
