local
  signature DATATYPE =
    sig
      datatype t = Zero | Succ of t
    end
in
  signature NATURAL =
    sig
      include INTEGRAL
      include DATATYPE

      type nat = t

      val + : t * t -> t
      val * : t * t -> t
    end
end
