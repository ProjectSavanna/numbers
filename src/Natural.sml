structure Natural :> NATURAL =
  struct
    datatype nat = Succ of nat | Zero
    type t = nat

    local
      val rec fromInt : IntInf.int -> nat = fn
        0 => Zero
      | n => Succ (fromInt (IntInf.- (n,1)))
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


    val rec op + = fn
      (Zero  ,n) => n
    | (Succ m,n) => Succ (m + n)

    val rec op - = fn
      (m     ,Zero  ) => m
    | (Succ m,Succ n) => m - n
    | (Zero  ,Succ _) => Zero

    val rec op * = fn
      (Zero  ,n) => Zero
    | (Succ m,n) => m * n + n


    val rec min = fn
      (Zero  ,Zero  ) => Zero
    | (Zero  ,Succ _) => Zero
    | (Succ _,Zero  ) => Zero
    | (Succ m,Succ n) => Succ (min (m,n))

    val rec max = fn
      (Zero  ,Zero  ) => Zero
    | (Zero  ,Succ n) => Succ n
    | (Succ m,Zero  ) => Succ m
    | (Succ m,Succ n) => Succ (min (m,n))
  end
