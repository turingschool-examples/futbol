module AssistantToTheGameTeamsManager
#-------------TeamStatsHelpers
  def game_info_by_team(team_id)
    @game_teams.select do |game_team|
      game_team.team_id == team_id
    end
  end

  def team_games_by_season(team_id)
    team_games_by_season = {}
    game_info_by_team(team_id).each do |game|
      (team_games_by_season[game.game_id.to_s[0..3]] ||= []) << game
    end
    team_games_by_season
  end

  def win_percentage_by_season(team_id)
    wins = {}
    team_games_by_season(team_id).each do |season, games|
      total_games = 0
      total_wins = 0
      games.each do |game|
       total_wins += 1 if game.result == 'WIN'
       total_games += 1
        end
        wins[season] = (total_wins.to_f / total_games).round(3)
      end
    wins
  end

  def result_totals_by_team(team_id)
    result = {}
    result[:total]  = game_info_by_team(team_id).length
    result[:wins]   = (find_all_game_results(team_id, "WIN")).length
    result[:ties]   = (find_all_game_results(team_id, "TIE")).length
    result[:losses] = (find_all_game_results(team_id, "LOSS")).length
    result
  end

  def find_all_game_results(team_id, result)
    game_info_by_team(team_id).select do |game|
      game.result == result
    end
  end

  def find_opponent_games(team_id)
    game_ids = game_info_by_team(team_id).map(&:game_id)
    @game_teams.select do |game_team|
      game_ids.include?(game_team.game_id) && game_team.team_id != team_id
    end
  end

  def find_opponent_win_percentage(team_id)
    opponent_games_by_team = find_opponent_games(team_id).group_by(&:team_id)
    win_percentage = {}
    opponent_games_by_team.each do |team_id, game_teams|
      total = 0
      opponent_wins = game_teams.count {|game_teams| game_teams.result == 'WIN'}
      win_percentage[team_id] = total += (opponent_wins.to_f / game_teams.length).round(2)
    end
    win_percentage
  end

  def find_team_name(team_id)
    @tracker.team_info(team_id)['team_name']
  end
end