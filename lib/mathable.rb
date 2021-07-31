module Mathable
  def hash_average(data)
    count, total = data.keys
    data[count].fdiv(data[total])
  end

  def average(num1, num2)
    num1.fdiv(num2)
  end
end
