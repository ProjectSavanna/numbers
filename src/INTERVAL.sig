signature INTERVAL =
  sig
    datatype interval = I of unit -> bool * interval

    include FLOATING where type t = interval

    val unfold : ('a -> bool * 'a) -> 'a -> interval

    val scale : IntInf.int -> IntInf.int -> interval
  end
