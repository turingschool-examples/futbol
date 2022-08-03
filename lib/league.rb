require './lib/details_loader'

class League < DetailsLoader

  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
    @details = DetailsLoader.new(games, teams, game_teams)
  end

  def highest_scoring_visitor #issue # 13 - Pass
      away_team_ids_array = (@games[:away_team_id]).uniq.sort

      team_ids_hash = {}
      away_team_ids_array.each do |teamid|
        team_ids_hash[teamid] = {sum_away_goals: 0, count_of_away_games_played: 0}
      end

      @games.each do |row|
        team_ids_hash[row[:away_team_id]][:sum_away_goals] += row[:away_goals]
        team_ids_hash[row[:away_team_id]][:count_of_away_games_played] += 1
      end

      averages_hash = {}
      team_ids_hash.keys.each do |teamid|
        averages_hash[teamid] = (team_ids_hash[teamid][:sum_away_goals]).to_f / (team_ids_hash[teamid][:count_of_away_games_played])
      end

      visitor_with_highest_score_array = averages_hash.max_by{|k,v| v}
      visitor_team_name_with_highest_avg_score = team_by_id[visitor_with_highest_score_array[0]]
  end

end
