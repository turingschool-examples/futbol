module Calculator
  def average(result, data)
    if data.class == Integer
      (result.to_f / data).round(2)
    else
      (result.to_f / data.length).round(2)
    end
  end
end
