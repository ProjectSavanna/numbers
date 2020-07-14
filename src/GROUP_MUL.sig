signature GROUP_MUL =
  sig
    include MONOID_MUL
    val inv : t -> t
    val /   : t * t -> t
  end
