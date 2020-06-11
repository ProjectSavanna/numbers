signature RATIONAL =
  sig
    type t

    (* infix 8 // *)
    val // : int * int -> t

    val hide : int * int -> t
    val show : t -> int * int

    val zero : t
    val one  : t

    val + : t * t -> t
    val ~ : t -> t
    val - : t * t -> t

    val * : t * t -> t
    val inv : t -> t
    val div : t * t -> t

    include ORDERED
  end
