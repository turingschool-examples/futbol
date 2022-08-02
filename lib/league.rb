require './lib/csv_loader'
require './lib/reusables'

class League < CsvLoader
include Reuseable


  def initialize(games, teams, game_teams)
    super(games, teams, game_teams)
  end

  def count_of_teams #issue # 10 - PASS
    @teams[:teamname].count
  end

  def best_offense #issue # 11 - Fail Wrong team returning
    max_average = average_scores_by_team_id("home", "away").values.max
    team_by_id[average_scores_by_team_id("home", "away").key(max_average)]
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
