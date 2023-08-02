module Calculable
  def percentage(value1, value2)
    if (value1.kind_of?(Integer) || value1.kind_of?(Float)) && (value2.kind_of?(Integer) || value2.kind_of?(Float))
      if value2 == 0
        p "#DIV/0!"
      else
        ((value1.to_f) / (value2.to_f) * 100).round(2)
      end
    else
      p "Inputs must be integers or floats."
    end
  end
end