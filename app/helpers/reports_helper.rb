module ReportsHelper
  def device_to_hex(d)
    if d
      "0x#{d.to_s(16)}"
    else
      "NONE"
    end
  end
end
