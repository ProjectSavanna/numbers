signature RATIONAL =
  sig
    include ORDERED SHOW GROUP_ADD GROUP_MUL

    structure Int : INTEGER

    (* infix 8 // *)
    val // : Int.int * Int.int -> t
    val show : t -> Int.int * Int.int

    val percent : t -> string
  end
