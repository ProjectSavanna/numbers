structure Interval :> INTERVAL =
  struct
    datatype bit = B0 | B1
    datatype interval = I of unit -> bit * interval
  end
