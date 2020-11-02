module Hashable
  def counter_sub_hash
    Hash.new {|stats, key| stats[key] = Hash.new {|sums, stat| sums[stat] = 0}}
  end

  def counter_hash
    Hash.new {|stats, key| stats[key] = 0}
  end

  def collector_hash
    Hash.new {|stats, key| stats[key] = []}
  end
end
