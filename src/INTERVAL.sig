signature INTERVAL =
  sig
    datatype interval = I of unit -> bool * interval

    val unfold : ('a -> bool * 'a) -> 'a -> interval

    val scale : Natural.t -> Natural.t -> interval

    include sig
      include FLOATING GROUP_ADD
    end where type t = interval
  end
