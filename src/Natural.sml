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
          then raise Domain
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


    local
      val rec divmod = fn (n,d) => (
        case compare (n,d) of
          LESS              => (Zero,n)
        | (EQUAL | GREATER) => (
            let
              val (q,r) = divmod (n - d, d)
            in
              (Succ q, r)
            end
          )
      )
    in
      val op div = #1 o divmod
      val op mod = #2 o divmod
    end


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
