signature NATURAL =
  sig
    datatype nat = Zero | Succ of nat

    include INTEGRAL where type t = nat

    val + : t * t -> t
    val * : t * t -> t
  end
