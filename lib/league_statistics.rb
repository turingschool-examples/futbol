require './lib/game_statistics'

class LeagueStatistics

  def count_of_teams(teams)
    teams.count
  end

  # def total_team_goals_all_season(game_data)
  #   overall_goals = {}
  #   game_data.each do |team_name, season|
  #     require "pry"; binding.pry
  #     overall_goals[team_name] = (season.away_goals + season.home_goals)
  #   end
  #   overall_goals
  # end
  def best_offense(game_teams_data)
team_goals = Hash.new {|hash, key| hash[key] = 0}
    game_teams_data.each do |game_id, game_pair|
      game_pair.each do |hoa, game_obj|
        team_goals[game_obj.team_id] += game_obj.goals
      end
    end
    team_goals
  end

  def total_goal_by_team(game_team_data)
    team_goals = Hash.new {|hash, key| hash[key] = 0}
    total_games = Hash.new {|hash, key| hash[key] = 0}
    game_teams_data.each do |game_id, game_pair|
      game_pair.each do |hoa, game_obj|
        team_goals[game_obj.team_id] += game_obj.goals
        total_games[game_obj.team_id] += 1
        end
      end
    team_goals
  end
end
