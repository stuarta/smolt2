module StatsHelper
  def total_items(item_hash)
    count = 0
    item_hash.each do |k, v|
      count += v
    end
    count
  end
end
