functor Rational (Int : INTEGER) :> RATIONAL where Int = Int =
  let
    open Int
  in
    struct
      type t = Int.int * Int.int  (* (a, b) invariant: a, b coprime; b nonnegative *)

      structure Int = Int

      local
        val zero = Int.fromInt 0
        fun gcd (m, n) =
          if n = zero
            then m
            else gcd (n, m mod n)
      in
        infix 8 //
        val op // =
          fn (x, y) =>
            let
              val gcd = gcd (x, y)
            in
              (x div gcd, y div gcd)
            end
      end

      val show = Fn.id

      val zero : t = (Int.fromInt 0, Int.fromInt 1)
      val one  : t = (Int.fromInt 1, Int.fromInt 1)

      val eq : t * t -> bool = (op =)
      val compare = fn ((a, b), (x, y)) => Int.compare (a * y, b * x)
      val toString = fn (x, y) => Int.toString x ^ " // " ^ Int.toString y
      val percent =
        Fn.curry (Fn.flip (op ^)) "%"
        o Int.toString
        o (fn (a, b) => (Int.fromInt 100 * a) div b)

      val op + = fn ((a, b), (x, y)) => (a * y + b * x) // (b * y)
      val ~ = fn (a, b) => (~a, b)
      val op - = fn (r1, r2) => r1 + ~r2

      val op * = fn ((a, b), (x, y)) => (a * x) // (b * y)
      val inv = Fn.flip (op //)
      val op / = fn (r1, r2) => r1 * inv r2
    end
  end
