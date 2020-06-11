signature INTERVAL =
  sig
    datatype interval = I of unit -> bool * interval

    val unfold : ('a -> bool * 'a) -> 'a -> interval

    val scale : Natural.t -> Natural.t -> interval

    include FLOATING where type t = interval

    (* Result may not be productive! *)
    val + : t * t -> t

    val ~ : t -> t
  end
