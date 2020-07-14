signature RATIONAL =
  sig
    include ORDERED SHOW GROUP_ADD GROUP_MUL

    (* infix 8 // *)
    val // : int * int -> t
    val show : t -> int * int

    val percent : t -> string
  end
