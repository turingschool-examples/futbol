require "csv"
require_relative "./game_teams"
require_relative "./isolatable"

class GameTeamsStats
  include Isolatable

  attr_reader :game_teams

  def initialize(game_teams)
    @game_teams = game_teams
  end

  def self.from_csv(location)
    game_teams = CSV.parse(File.read(location), headers: true, header_converters: :symbol).map(&:to_h)
    game_teams_as_objects = game_teams.map { |row| GameTeams.new(row) }
    GameTeamsStats.new(game_teams_as_objects)
  end

  def most_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.max
  end

  def fewest_goals_scored(team_id)
    goals_by_game = []
    @game_teams.each do |game|
      goals_by_game << game.goals.to_i if team_id == game.team_id
    end
    goals_by_game.min
  end

  def best_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }

    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #create an average out of the scores
      end
  end

  def worst_offense
    team_scores = Hash.new { |h, k| h[k] = [] }
    @game_teams.each { |game_team| team_scores[game_team.team_id] << game_team.goals.to_f }
    team_scores_average =
      team_scores.map do |id, scores|
        [id, ((scores.sum) / (scores.length)).round(2)] #creat an average out of the scores
      end
  end

  def number_of_tackles(team_id, game_id)
    tackles = 0
    @game_teams.each do |game_team|
      if team_id == game_team.team_id && game_id == game_team.game_id
        tackles += game_team.tackles.to_i
      end
    end
    tackles
  end

  def coach_percentage_loss(coaches, game_id_list)
    coaches = isolate_coach_loss(game_id_list)
    coach_percentage_lost =
      coaches.map do |coach_name, game_loss|
        percentage_lost = (game_loss.to_f / game_id_list.length) * 100
        [coach_name, percentage_lost]
      end.to_h
  end

  def coach_percentage_won(coaches, game_id_list)
    coaches = isolate_coach_wins(game_id_list)
    coach_percentage_won =
      coaches.map do |coach_name, game_won|
        percentage_won = (game_won.to_f / game_id_list.length) * 100
        [coach_name, percentage_won]
      end.to_h
  end

  def all_game_results(team_id)
    all_game_results = Hash.new { |h, k| h[k] = { is_our_team: false, other_team_id: nil, winning_team_id: nil } }
    @game_teams.each do |game|
      game_id = game.game_id
      winner = nil
      if game.result == "WIN"
        winner = game.team_id
      end
      if game.team_id == team_id
        all_game_results[game_id][:is_our_team] = true
      else
        all_game_results[game_id][:other_team_id] = game.team_id
      end
      if winner
        all_game_results[game_id][:winning_team_id] = winner
      end
    end
    all_game_results
  end

  def record_vs_our_team(team_id)  
    all_game_results = all_game_results(team_id)
    our_team_results = all_game_results
    .find_all { |game_id, teams_hash| teams_hash[:is_our_team] }
    .to_h
    record_vs_our_team = Hash.new { |h, k| h[k] = { wins: 0.0, losses: 0.0, ties: 0.0 } }
    our_team_results.each do |game_id, teams_hash|
      other_team_id = teams_hash[:other_team_id]
      if teams_hash[:winning_team_id] == team_id
        record_vs_our_team[other_team_id][:losses] += 1
      elsif teams_hash[:winning_team_id] == other_team_id
        record_vs_our_team[other_team_id][:wins] += 1
      else
        record_vs_our_team[other_team_id][:ties] += 1
      end
    end
    record_vs_our_team
  end

  def min_win_percent(team_id)
    record_vs_our_team = record_vs_our_team(team_id)
    our_favorite_opponent =                            
    record_vs_our_team.min do |team_win_1, team_win_2|
      win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
      win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
      win_percentage_1 <=> win_percentage_2
    end
    our_favorite_opponent
  end

  def max_win_percent(team_id)
    record_vs_our_team = record_vs_our_team(team_id)
    our_rival =                            
    record_vs_our_team.max do |team_win_1, team_win_2|
      win_percentage_1 = (team_win_1[1][:wins] / (team_win_1[1][:losses] + team_win_1[1][:ties] + team_win_1[1][:wins])) * 100
      win_percentage_2 = (team_win_2[1][:wins] / (team_win_2[1][:losses] + team_win_2[1][:ties] + team_win_2[1][:wins])) * 100
      win_percentage_1 <=> win_percentage_2
    end
    our_rival
  end
end
