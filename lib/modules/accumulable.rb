module Accumulable
  
  def game_team_info_by_season(season, stat = nil)
    gameteams = GameTeam.season_games(Game.games_in_a_season(season))

    accumulator = Hash.new(0)
      gameteams.each_value do |gameteam|
        gameteam.each_value do |team|
          if stat == "tackles"
            accumulator[team.team_id] += team.tackles
          elsif stat == "shots"
            accumulator[team.team_id] = Hash.new(0) if !accumulator.has_key?(team.team_id)
            accumulator[team.team_id][:shots] += team.shots
            accumulator[team.team_id][:goals] += team.goals
          end
        end
      end
    accumulator
  end
end
