signature MONOID_MUL =
  sig
    type t
    val one : t
    val * : t * t -> t
  end
