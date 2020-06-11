local
  signature DATATYPE =
    sig
      datatype bit = B0 | B1
      datatype t = I of unit -> bit * t
    end
in
  signature INTERVAL =
    sig
      include DATATYPE

      type interval = t
    end
end
