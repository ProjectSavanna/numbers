signature INTERVAL =
  sig
    datatype bit = B0 | B1
    datatype interval = I of unit -> bit * interval

    include FLOATING where type t = interval

    val unfold : ('a -> bit * 'a) -> 'a -> interval

    val scale : IntInf.int -> IntInf.int -> interval
  end
