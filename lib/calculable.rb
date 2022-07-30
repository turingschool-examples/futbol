module Calculable

  def id_team_hash
    id_and_team = {}
    @teams.each do |team|
      id_and_team[team[:team_id]] = team[:teamname]
    end
    id_and_team
  end
end