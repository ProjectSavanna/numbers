signature NATURAL =
  sig
    datatype nat = Zero | Succ of nat

    include sig
      include INTEGRAL MONOID_ADD MONOID_MUL
    end where type t = nat

    val - : t * t -> t  (* iterated predecessor *)
  end
