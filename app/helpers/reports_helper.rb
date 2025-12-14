module ReportsHelper
  def device_to_hex(d)
    if d and d != -1
      "0x#{d.to_s(16)}"
    else
      "NONE"
    end
  end
  def show_class_or_arrival(device, show_class, show_recent)
    if show_class
      "#{device.device_class.name}"
    elsif show_recent
      "#{device.updated_at}"
    else
      ""
    end
  end
  def show_class_or_arrival_header(show_class, show_recent)
    if show_class
      "Class"
    else
      "Arrived at"
    end
  end
end
