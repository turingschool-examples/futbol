module Hashable
  def hash_builder(hash_name, key, value)
      hash_name[key] = [] if hash_name[key].nil?
      hash_name[key] << value
      hash_name
  end

  def hash_key_max_by(hash)
    hash.key(hash.values.max)
  end

  def hash_key_min_by(hash)
    hash.key(hash.values.min)
  end
end
