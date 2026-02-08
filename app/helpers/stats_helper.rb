module StatsHelper
  def total_items(item_hash)
    count = 0
    item_hash.each do |k, v|
      count += v
    end
    count
  end
  def total_items_from_hash(item_hash)
    count = 0
    item_hash.each do |k, v|
      count += v[:count]
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
  def pretty_fs_bucket_name(bucket_name)
    case bucket_name
    when "0_to_2Gb"
      "0 to 2 Gb"
    when "2Gb_to_100Gb"
      "2 to 100 Gb"
    when "100Gb_to_200Gb"
      "100 to 200 Gb"
    when "200Gb_to_400Gb"
      "200 to 400 Gb"
    when "400Gb_to_700Gb"
      "400 to 700 Gb"
    when "700Gb_to_1Tb"
      "700 Gb to 1 Tb"
    when "1Tb_to_2Tb"
      "1 to 2 Tb"
    when "2Tb_to_4Tb"
      "2 to 4 Tb"
    when "4Tb_to_8Tb"
      "4 to 8 Tb"
    when "8Tb_plus"
      "8 Tb plus"
    else
      bucket_name
    end
  end
end
