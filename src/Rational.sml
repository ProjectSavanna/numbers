structure Rational :> RATIONAL =
  struct
    type t = int * int  (* (a,b) invariant: a,b coprime; b nonnegative *)

    local
      val rec gcd = fn
        (m,0) => m
      | (m,n) => gcd (n, m mod n)
    in
      val hide = fn (x,y) => (
        let
          val gcd = gcd (x,y)
        in
          (x div gcd, y div gcd)
        end
      )
    end
    val show = Fn.id

    infix 8 //
    val op // = hide

    val zero = (0,1)
    val one  = (1,1)

    val equal : t * t -> bool = (op =)
    val compare = fn ((a,b),(x,y)) => Int.compare (a * y, b * x)

    val op + = fn ((a,b),(x,y)) => (a * y + b * x) // (b * y)
    val ~ = fn (a,b) => (~a,b)
    val op - = fn (r1,r2) => r1 + ~r2

    val op * = fn ((a,b),(x,y)) => (a * x) // (b * y)
    val inv = fn (a,b) => (b,a)
    val op div = fn (r1,r2) => r1 * inv r2
  end
