require 'csv'

class GameTeamManager
  attr_reader :game_teams,
              :tracker
  def initialize(path, tracker)
    @game_teams = []
    create_underscore_game_teams(path)
    @tracker = tracker
  end

  def create_underscore_game_teams(path)
    game_teams_data = CSV.read(path, headers: true)
    @game_teams = game_teams_data.map do |data|
      GameTeam.new(data, self)
    end
  end

  def average_win_percentage(team_id)
    team_game_count = Hash.new(0)
    team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game.team_id == team_id
        team_game_count[game.team_id] += 1
        if game.result == "WIN"
          team_wins[game.team_id] += 1
        end
      end
    end
    (team_wins[team_id].to_f / team_game_count[team_id]).round(2)
  end

  def best_offense
    team_ids = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team|
      team_ids[game_team.team_id] += game_team.goals
      team_game_count[game_team.team_id] += 1
    end
    highest_scoring_team = team_ids.max_by do |team, score|
      score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(highest_scoring_team)
  end

  def worst_offense
    team_ids = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team|
      team_ids[game_team.team_id] += game_team.goals
      team_game_count[game_team.team_id] += 1
    end
    lowest_scoring_team = team_ids.min_by do |team, score|
      score.to_f / team_game_count[team]
    end[0]
    @tracker.get_team_name(lowest_scoring_team)
  end

  def find_winningest_coach(game_ids, expected_result)
    coach_game_count = Hash.new(0)
    coach_wins = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        coach_game_count[game.head_coach] += 1
        if game.result == expected_result
          coach_wins[game.head_coach] += 1
        end
      end
    end
    coach_wins.max_by do |coach, win| # Perhaps a get_max_of(coach_wins)
      win / coach_game_count[coach]
    end[0]
  end

  def find_worst_coach(game_ids)
    coach_game_count = Hash.new(0)
    coach_losses = Hash.new(0.0)
    @game_teams.each do |game|
      if game_ids.include?(game.game_id)
        coach_game_count[game.head_coach] += 1
        if game.result == "LOSS" || game.result == "TIE"
          coach_losses[game.head_coach] += 1
        end
      end
    end
    coach_losses.max_by do |coach, loss|
      loss / coach_game_count[coach]
    end[0]
  end
end
