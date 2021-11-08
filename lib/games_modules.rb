module GamesEnumerables

  def return_percentage(counter, data)
    ((counter.to_f / data.length) * 100).round(2)
  end

  def get_average(counter, data)
    (counter / data.count).round(2)
  end
end
