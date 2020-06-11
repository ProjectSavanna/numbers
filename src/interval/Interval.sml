structure Interval :> INTERVAL =
  struct
    datatype bit = B0 | B1
    datatype interval = I of unit -> bit * interval
    type t = interval

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
  end
