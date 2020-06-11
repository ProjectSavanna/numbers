structure Interval :> INTERVAL =
  struct
    datatype bit = B0 | B1
    datatype t = I of unit -> bit * t
    type interval = t
  end
