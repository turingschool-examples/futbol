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

  def find_all_teams(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id
    end
  end

  def most_goals_scored(team_id)
    # max_goals = @game_teams.find_all do |game|
    #   game.team_id == team_id
    # end
    high_goals = find_all_teams(team_id).max_by do |game|
      game.goals
    end
    high_goals.goals
  end

  def fewest_goals_scored(team_id)
    low_goals = find_all_teams(team_id).min_by do |game|
      game.goals
    end
    low_goals.goals
  end

  def find_game_ids(team_id)
    find_all_teams(team_id).map do |game|
      game.game_id
    end
  end

  def favorite_opponent(team_id)
    total_games = Hash.new(0)
    loser_loses = Hash.new(0)
    @game_teams.each do |game|
      if find_game_ids(team_id).include?(game.game_id) && game.team_id != team_id
        total_games[game.team_id]  += 1
        if game.result == "LOSS"
          loser_loses[game.team_id] += 1
        end
      end
    end
    biggest_loser = loser_loses.max_by do |loser, losses|
      losses.to_f / total_games[loser]
    end
    biggest_loser_name = @teams.find do |team|
      biggest_loser[0] == team.team_id
    end
    biggest_loser_name.teamName
  end

end
