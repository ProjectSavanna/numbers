signature INTERVAL =
  sig
    datatype interval = I of unit -> bool * interval

    include FLOATING where type t = interval

    val unfold : ('a -> bool * 'a) -> 'a -> interval

    val scale : Natural.t -> Natural.t -> interval

    (* May not terminate! *)
    val + : interval * interval -> interval
  end
