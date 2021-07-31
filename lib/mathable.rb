module Mathable
  def average(data)
    count, total = data.keys
    data[count].fdiv(data[total])
  end
end
