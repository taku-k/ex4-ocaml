%{
open Syntax
%}

%token LPAREN RPAREN SEMISEMI
%token PLUS MULT LT
%token IF THEN ELSE TRUE FALSE

%token <int> INTV
%token <Syntax.id> ID

%start toplevel
%type <Syntax.program> toplevel
%%

toplevel :
    Expr SEMISEMI { Exp $1 }

Expr :
    IfExpr { $1 }
  | LTExpr { $1 }
  | { ErrorExp ("Syntax Error") }

LTExpr : 
    PExpr LT PExpr { BinOp (Lt, $1, $3) }
  | PExpr { $1 }
  | { ErrorExp ("Unbound Error") }

PExpr :
    PExpr PLUS MExpr { BinOp (Plus, $1, $3) }
  | MExpr { $1 }
  | {ErrorExp ("Unbound Error") }

MExpr : 
    MExpr MULT AExpr { BinOp (Mult, $1, $3) }
  | AExpr { $1 }
  | { ErrorExp ("Unbound Error") }

AExpr :
    INTV { ILit $1 }
  | TRUE { BLit true }
  | FALSE { BLit false }
  | ID { Var $1 }
  | LPAREN Expr RPAREN { $2 }
  | { ErrorExp ("Unbound Error") }

IfExpr :
    IF Expr THEN Expr ELSE Expr { IfExp ($2, $4, $6) }
  | { ErrorExp ("Unbound Error") }
   
