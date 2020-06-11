structure Natural :> NATURAL =
  struct
    datatype t = Succ of t | Zero
    type nat = t

    val rec op + = fn
      (Zero  ,n) => n
    | (Succ m,n) => Succ (m + n)

    val rec op * = fn
      (Zero  ,n) => Zero
    | (Succ m,n) => m * n + n

    local
      val rec fromInt : IntInf.int -> nat = fn
        0 => Zero
      | n => Succ (fromInt (n - 1))
    in
      val fromInt = fn n =>
        if n < 0
          then raise Fail "Natural number cannot be negative"
          else fromInt n
    end

    val rec toInt = fn
      Zero   => 0
    | Succ n => IntInf.+ (toInt n, 1)

    val rec compare = fn
      (Zero  ,Zero  ) => EQUAL
    | (Zero  ,Succ _) => LESS
    | (Succ _,Zero  ) => GREATER
    | (Succ m,Succ n) => compare (m,n)
  end
