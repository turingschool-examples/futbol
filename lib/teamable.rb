module Teamable

  def team_name(klass, team_id)
    klass.all.find { |team| team_id == team.team_id }.team_name
  end

end
