module Hashable
  def hash_builder(hash_name, key, value)
      hash_name[key] = [] if hash_name[key].nil?
      hash_name[key] << value
      hash_name
  end
end
