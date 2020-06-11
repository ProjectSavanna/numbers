structure Interval :> INTERVAL =
  struct
    datatype interval = I of unit -> bool * interval
    type t = interval

    local
      val rec aux = fn () => I (fn () => (false,aux ()))
      val zero = aux ()
    in
      val rec fromFloat = fn r => (
        if Real.== (r,0.0)
          then zero
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

    local
      val double = Fn.curry Natural.* (Natural.fromInt 2)
      val op >= = fn (a,b) => (
        case Natural.compare (a,b) of
          LESS    => false
        | EQUAL   => true
        | GREATER => true
      )
    in
      val scale = fn n => unfold (fn k =>
        let
          val k2 = double k
          val b = k2 >= n
        in
          (b, if b then Natural.- (k2,n) else k2)
        end
      ) o Fn.curry Natural.min n  (* treat numbers above bound as at bound *)
    end


    local
      val peek = fn b => fn r => (if b then Fn.id else not) (r ())
      val carry = fn
        (false,false) => Fn.const
      | (false,true ) => peek
      | (true ,false) => peek
      | (true ,true ) => Fn.const o not
    in
      val rec op + = fn (I f,I g) => I (fn () =>
        let
          val (b1,I f') = f ()
          val (b2,I g') = g ()
          val (b1',_) = f' ()
          val (b2',_) = g' ()
          val rest as I r = I f' + I g'
        in
          (carry (b1',b2') (b1 <> b2) (#1 o r), rest)
        end
      )
    end
  end
