structure Interval :> INTERVAL =
  struct
    datatype bit = B0 | B1
    datatype interval = I of unit -> bit * interval
    type t = interval

    local
      val rec aux = fn () => I (fn () => (B0,aux ()))
    in
      val rec fromFloat = fn r => (
        if Real.== (r,0.0)
          then aux ()
          else (
            let
              val (b,r') =
                if r >= 0.5
                  then (B1, r - 0.5)
                  else (B0, r      )
            in
              I (Fn.const (b,fromFloat (2.0 * r')))
            end
          )
      )
    end

    local
      fun aux pow 0 _ = 0.0
        | aux pow n (I f) = (
            let
              val (b,f') = f ()
              val res = aux (pow / 2.0) (n - 1) f'
            in
              case b of
                B0 => res
              | B1 => res + pow
            end
          )
    in
      val toFloat = aux 0.5 Real.precision
    end

    local
      val aux = fn
        (B0,B0) => EQUAL
      | (B0,B1) => LESS
      | (B1,B0) => GREATER
      | (B1,B1) => EQUAL
    in
      val rec compare = fn (I f, I g) => (
        let
          val (f0,f') = f ()
          val (g0,g') = g ()
        in
          case aux (f0,g0) of
            LESS    => LESS
          | EQUAL   => compare (f',g')
          | GREATER => GREATER
        end
      )
    end

    fun unfold f x = I (fn () =>
      let
        val (b,x') = f x
      in
        (b,unfold f x')
      end
    )

    val scale = fn n : IntInf.int =>
      unfold (fn k => if 2 * k >= n then (B1, 2 * k - n) else (B0, 2 * k))
  end
