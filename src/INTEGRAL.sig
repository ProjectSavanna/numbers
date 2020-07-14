signature INTEGRAL =
  sig
    type t
    val fromInt : IntInf.int -> t
    val toInt   : t -> IntInf.int

    include ORDERED

    val div : t * t -> t
    val mod : t * t -> t

    val min : t * t -> t
    val max : t * t -> t
  end
