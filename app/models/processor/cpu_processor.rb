class Processor::CpuProcessor
  def find_or_create_cpu!(family, stepping, model_num, vendor, model)
    begin
      c = Core::Cpu.find_or_create_by!(cpu_family: family, cpu_stepping: stepping, cpu_model_num: model_num, cpu_vendor: vendor, cpu_model: model)
    rescue ActiveRecord::RecordNotUnique
      retry
    end
    c.save!
    # Return cpu object
    c
  end
end
