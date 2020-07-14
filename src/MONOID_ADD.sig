signature MONOID_ADD =
  sig
    type t
    val zero : t
    val + : t * t -> t
  end
