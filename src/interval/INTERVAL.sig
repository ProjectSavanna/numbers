signature INTERVAL =
  sig
    datatype bit = B0 | B1
    datatype interval = I of unit -> bit * interval

    include ORDERED where type t = interval
  end
