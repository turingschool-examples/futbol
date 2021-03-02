module Mathable
  def arry_percentage(array1, array2)
    percent = array1.length.to_f / array2.length.to_f
    readable_percent = percent.round(2)
  end
end
