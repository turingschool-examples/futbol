module Calculable
  def percentage(value1, value2)
    if (value1.kind_of?(Integer) || value1.kind_of?(Float)) && (value2.kind_of?(Integer) || value2.kind_of?(Float))
      if value2 == 0
        p "#DIV/0!"
      else
        ((value1.to_f) / (value2.to_f) * 100).round(2)
      end
    else
      p "Inputs must be integers and/or floats."
    end
  end

  def average(array)
    # This method got a little complicated. The line below is meant to be a filter that removes any input that isn't an array OR is empty OR is an array that contains elements that aren't either an integer or float 
    if !array.kind_of?(Array) || array.empty? || !array.reject {|element| element.kind_of?(Integer) || element.kind_of?(Float)}.empty?
      p "Input must be an array of integers and/or floats."
    else
      (array.sum.to_f / array.count).round(2)
    end
  end
end