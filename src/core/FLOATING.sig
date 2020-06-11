signature FLOATING =
  sig
    type t
    val fromFloat : Real.real -> t
    val toFloat   : t -> Real.real

    include ORDERED
  end
