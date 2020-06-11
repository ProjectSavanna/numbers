signature FLOATING =
  sig
    type t
    val fromFloat : Real.real -> t
    val toFloat   : t -> Real.real
    val floor     : int -> t -> Real.real

    include ORDERED
  end
