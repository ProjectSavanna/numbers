signature RATIONAL =
  sig
    include ORDERED SHOW

    (* infix 8 // *)
    val // : int * int -> t
    val show : t -> int * int

    val zero : t
    val one  : t

    val + : t * t -> t
    val ~ : t -> t
    val - : t * t -> t

    val *   : t * t -> t
    val inv : t -> t
    val /   : t * t -> t

    val percent : t -> string
  end
