signature GROUP_ADD =
  sig
    include MONOID_ADD
    val ~ : t -> t
    val - : t * t -> t
  end
