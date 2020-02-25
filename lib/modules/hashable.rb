module Hashable
  def hash_builder(hash_name, key, value)
      hash_name[key] = [] if hash_name[key].nil?
      hash_name[key] << value
      hash_name
  end
<<<<<<< HEAD
  
=======

>>>>>>> 60ba41394efd826c7b96a8acabf45d4f82c6b804
  def hash_key_max_by(hash)
    hash.key(hash.values.max)
  end

  def hash_key_min_by(hash)
    hash.key(hash.values.min)
  end
end
