module Calculable

  def id_team_key
    @teams[:team_id].zip(@teams[:teamname]).to_h
  end

  def module_ratio(param1, param2)
    #params must be a hash.
    ratio = param1.merge(param2) do |key, param1, param2|
      param1.to_f / param2
    end
    ratio
  end

  def module_sum(param1, param2)
    #params must be a hash.
    sum = param1.merge(param2) do |key, param1, param2|
      param1 + param2
    end
    sum
  end

  def module_highest(variable)
    variable.max_by{|key, value| value}.first
  end

  def module_lowest(variable)
    variable.min_by{|key, value| value}.first
  end
end