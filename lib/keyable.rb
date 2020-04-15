module Keyable

  def high_low_key_return(given_hash, high_low)
    if high_low == "high"
      @chosen_key = given_hash.max_by {|k,v| v}[0]
    elsif high_low == "low"
      @chosen_key = given_hash.min_by {|k,v| v}[0]
    end
  end
  
end
