module Hashable

    def hash_of_hashes(collection, key1, key2, key3, value2, value3, arg2 = nil )
      # {key1 => { key2 => value2, key3 => value3}} across collection. arg2 is ignored if not needed
      # arg2 is optional if the passed method requires arguments
      hash_of_hashes = Hash.new { |hash, key| hash[key] = {key2 => 0, key3 => 0}}
      collection.each do |game|
        hash_of_hashes[game.send(key1)][key2] += game.send(value2) if arg2.nil?
        hash_of_hashes[game.send(key1)][key2] += game.send(value2, arg2) if !arg2.nil?
        hash_of_hashes[game.send(key1)][key3] += value3 if value3.is_a?(Numeric)
        hash_of_hashes[game.send(key1)][key3] += game.send(value3) if !value3.is_a?(Numeric)
      end
      hash_of_hashes
    end

    def divide_hash_values(key1, key2, og_hash)
      # accumulator hash {season => win%}
      hash_divided = Hash.new { |hash, key| hash[key] = 0 }
      # divide 2 hashe values and send to new hash value
      og_hash.map do |key, value|
        hash_divided[key] = (value[key1] / value[key2].to_f).round(2)
      end
      hash_divided
    end
end
