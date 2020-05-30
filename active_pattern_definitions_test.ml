module ComplexNumbers_Example = struct
  (* Dummy definitions *)
  type complex = 
      { real_part: float; imaginary_part: float }
      
  let magnitude (_t: complex) = 1.0
  let phase     (_t: complex) = 1.0
  
  module Complex = struct
    (* Dummy definitions *)
    let mk_rect  (a,b) = { real_part = a; imaginary_part = b }
    let mk_polar (a,b) = { real_part = a; imaginary_part = b }
  end
  
  let (|Rect |) (x : complex) = (x.real_part , x.imaginary_part)
  let (|Polar|) (x : complex) = (magnitude x, phase x)
end


module NaturalNumbers_Example = 
struct
  let (|Zero|Succ|) n = if n = 0 then Zero else Succ(n - 1)

  let (|Even|Odd|) n = if n mod 2 = 0 then Even(n / 2) else Odd(n - 1)
end


module FunctionalQueue_Example = 
struct
  let (|Reversed|) l = List.rev l
(*
  let (|NonEmpty|Empty|) q =
    match q with
    | (h::t), r               -> NonEmpty(h,(t,r))
    | []    , Reversed (h::t) -> NonEmpty(h,(t,[]))
    | _                       -> Empty()
*)
end

(*
module JoinList_ExampleA = struct
  type ilist = 
    | Empty 
    | Single of int 
    | Join of ilist * ilist

  let rec (|Cons|Nil|) inp =
    match inp with  
    | Single x                -> Cons(x, Empty)
    | Join (Cons (x,xs), ys)  -> Cons(x, Join (xs, ys))
    | Join (Nil, Cons (y,ys)) -> Cons(y, Join (ys, Empty))
    | _                       -> Nil()

  let head js = 
    match js with 
    | Cons (x,_) -> x
    | _          -> failwith "empty list"
end
*)

(*
module JoinList_Example = struct
  type ilist = 
    | Empty 
    | Single of int 
    | Join   of ilist * ilist
  
  let rec (|Cons|Nil|) = function 
    | Single x                   -> Cons(x, Empty)
    | Join (Cons (x,xs), ys)     -> Cons(x, Join (xs, ys))
    | Join (Nil (), Cons (y,ys)) -> Cons(y, Join (ys, Empty))
    | _                          -> Nil()

  let head js = 
    match js with 
    | Cons (x,_) -> x
    | _ -> failwith "empty list"

  let rec map f xs =
    match xs with
    | Cons (y,ys) -> Join (Single (f y), map f ys)
    | Nil ()      -> Empty

  let rec to_list xs =
    match xs with
    | Cons (y,ys) -> y :: to_list ys
    | Nil () -> []
end
*)

(*
module PolyJoinList_Example = struct
  type 'a jlist = 
    | Empty 
    | Single of 'a 
    | Join   of 'a jlist * 'a jlist

  let rec (|JCons|JNil|) = function 
    | Single x                     -> JCons(x, Empty)
    | Join (JCons (x,xs), ys)      -> JCons(x, Join (xs, ys))
    | Join (JNil (), JCons (y,ys)) -> JCons(y, Join (ys, Empty))
    | Empty 
    | Join (JNil (), JNil ()) -> JNil()

  let jhead js = 
    match js with 
    | JCons (x,_) -> x
    | JNil        -> failwith "empty list"

  let rec jmap f xs =
    match xs with
    | JCons (y,ys) -> Join (Single (f y), jmap f ys)
    | JNil ()      -> Empty

  let rec jlist_to_list xs =
    match xs with
    | JCons (y,ys) -> y :: jlist_to_list ys
    | JNil ()      -> []
end
*)

(*
module UnZip_Example = struct
  let rec (|Unzipped|) = function 
    | ((x,y) :: Unzipped (xs, ys)) -> (x :: xs, y :: ys)
    | []                           -> ([], [])
end
*)


module PartialPattern_Examples = 
struct
  let (|MulThree|_|) inp = 
    if inp mod 3 = 0 then Some(inp / 3) else None
  let (|MulSeven|_|) inp = 
    if inp mod 7 = 0 then Some(inp / 7) else None
end
     

module ParameterizedPartialPattern_Examples = 
struct
  let (|Equal|_|) x y = 
    Printf.printf "x = %d!\n" x;
    if x = y then Some() else None

  let (|Lookup|_|) x tbl = Hashtbl.find_opt tbl x
end

(*
module RegExp = 
struct
  let (|IsMatch|_|) (pat:string) (inp:string) = 
    let r = Str.regexp ("^" ^ pat ^ "$") in
    if Str.string_match r inp 0 then Some(inp) else None
end
*)
