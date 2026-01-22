module StatsHelper
  def total_items(item_hash)
    count = 0
    item_hash.each do |k, v|
      count += v
    end
    count
  end
  def pretty_memory_bucket_name(bucket_name)
    case bucket_name
    when "0_to_2Gb"
      "0 to 2 Gb"
    when "2_to_4Gb"
      "2 to 4 Gb"
    when "4_to_8Gb"
      "4 to 8 Gb"
    when "8_to_16Gb"
      "8 to 16 Gb"
    when "16_to_32Gb"
      "16 to 32 Gb"
    when "32_to_64Gb"
      "32 to 64 Gb"
    when "64_to_128Gb"
      "64 to 128 Gb"
    when "128Gb_plus"
      "128 Gb plus"
    else
      bucket_name
    end
  end
end
