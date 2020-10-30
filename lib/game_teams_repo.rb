require 'CSV'
require './lib/game_teams'
class GameTeamsRepo
  attr_reader :parent,
              :game_teams

  def initialize(path, parent)
    @parent = parent
    @game_teams = create_game_teams(path)
  end

  def create_game_teams(path)
    rows = CSV.readlines('./data/game_teams.csv', headers: :true , header_converters: :symbol)

    rows.map do |row|
      GameTeams.new(row, self)
    end
  end

  def find_team_by(id)
    @game_teams.find_all do |game_team|
      game_team.team_id == id
    end
  end

  def average_goals_by(id)
    team_games = find_team_by(id)

    total_goals = team_games.sum do |team_game|
      team_game.goals
    end
    (total_goals.to_f / team_games.count).round(2)
  end

  def team_ids
    team_ids = []

    @game_teams.each do |game_team|
      team_ids << game_team.team_id
    end
    team_ids.uniq
  end

  def highest_average_goals
    ids = team_ids
    ids.max_by do |id|
      average_goals_by(id)
    end
  end

  def lowest_average_goals
   
    ids = team_ids
    ids.min_by do |id|
      average_goals_by(id)
    end
  end

  def games_containing(header, value, games = @game_teams)
    games.select do |game|
      game.send(header) == value
    end
  end

  def percentage_wins(hoa)
    games = games_containing(:hoa, hoa)
    wins = games_containing(:result, "WIN", games).count.to_f 
    (wins / games.count).round(2)
  end
  
  def percentage_ties
    games = games_containing(:hoa, "home")
    ties = games_containing(:result, "TIE", games).count.to_f 
    (ties / games.count).round(2)
  end
end
#add percentage games stats methods
