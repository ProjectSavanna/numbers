structure Interval :> INTERVAL =
  struct
    datatype interval = I of unit -> bool * interval
    type t = interval

    local
      val rec aux = fn () => I (fn () => (false,aux ()))
    in
      val rec fromFloat = fn r => (
        if Real.== (r,0.0)
          then aux ()
          else (
            let
              val b = r >= 0.5
              val r' = if b then r - 0.5 else r
            in
              I (Fn.const (b,fromFloat (2.0 * r')))
            end
          )
      )
    end

    local
      fun aux pow Natural.Zero _ = 0.0
        | aux pow (Natural.Succ n) (I f) = (
            let
              val (b,f') = f ()
              val res = aux (pow / 2.0) n f'
            in
              case b of
                false => res
              | true  => res + pow
            end
          )
    in
      val floor = aux 0.5
      val toFloat = (floor o Natural.fromInt o IntInf.fromInt) Real.precision
    end

    local
      val aux = fn
        (false,false) => EQUAL
      | (false,true ) => LESS
      | (true ,false) => GREATER
      | (true ,true ) => EQUAL
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

    val scale = fn n : IntInf.int => unfold (fn k =>
      let
        val k2 = k * 2
        val b = k2 >= n
      in
        (b, if b then k2 - n else k2)
      end
    )
  end
