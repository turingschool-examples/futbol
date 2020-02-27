module Nameable

  def max_team_name(arg)
    team_name_by_id(arg.key(arg.values.max))
  end

  def min_team_name(arg)
    team_name_by_id(arg.key(arg.values.min))
  end
end
