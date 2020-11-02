class GameTeam
  attr_reader :team_id,
              :head_coach,
              :shots,
              :tackles,
              :goals,
              :result




  def initialize(row)
    @team_id = row["team_id"].to_i
    @HoA = row["HoA"]
    @result = row["result"]
    @head_coach = row["head_coach"]
    @goals = row["goals"].to_i
    @shots = row["shots"].to_i
    @tackles = row["tackles"].to_i
  end
end
