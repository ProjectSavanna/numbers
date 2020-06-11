signature INTEGRAL =
  sig
    type t
    val fromInt : IntInf.int -> t
    val toInt   : t -> IntInf.int

    include ORDERED
  end
