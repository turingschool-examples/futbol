require 'CSV'
require 'pry'

require_relative './game_teams'
require_relative './teams_manager'

class GameTeamsManager
  attr_reader :game_teams_objects, :game_teams_path, :teams, :games

  def initialize(game_teams_path)
    @game_teams_path = './data/game_teams.csv'
    @game_teams_objects = (
      objects = []
      CSV.foreach(game_teams_path, headers: true, header_converters: :symbol) do |row|
        objects << GameTeams.new(row)
      end
      objects)
    @teams = TeamManager.new('./data/teams.csv').team_objects

    @games = GameManager.new('./data/games.csv').game_objects

  end

  def games_by_team_id(team_id, hoa = nil)
    @game_teams_objects.find_all do |game|
      if hoa == nil
        game.team_id == team_id
      else
        game.hoa == hoa && game.team_id == team_id
      end
    end
  end

  def total_goals_by_team(team_id, hoa = nil)
    games_by_team_id(team_id, hoa).sum do |game|
      game.goals
    end
  end

  def average_goals_per_game_by_id(team_id, hoa = nil)
    average = total_goals_by_team(team_id, hoa) / games_by_team_id(team_id, hoa).count.to_f
    average.round(2)

  end

  def wins_by_team_id(team_id, hoa = nil) #test
    games_by_team_id(team_id, hoa).find_all do |game|
        game.result == "WIN"
    end
  end

  def average_win_percentage(team_id, hoa = nil)
    win_percent = wins_by_team_id(team_id).count
    other_percent = games_by_team_id(team_id,).count
    total = win_percent.to_f/other_percent
    total.round(2)
  end

  def best_offense
    best_team = teams.max_by { |team| average_goals_per_game_by_id(team.team_id) }
    best_team.teamname
  end

  def worst_offense
    worst_team = teams.min_by { |team| average_goals_per_game_by_id(team.team_id) }
    worst_team.teamname
  end

  def highest_scoring_visitor
    highest_visitor = teams.max_by { |team| average_goals_per_game_by_id(team.team_id, "away") }
    highest_visitor.teamname
  end

  def highest_scoring_home_team
    highest_home = teams.max_by { |team| average_goals_per_game_by_id(team.team_id, "home") }
    highest_home.teamname
  end

  def lowest_scoring_visitor
    lowest_visitor = teams.min_by { |team| average_goals_per_game_by_id(team.team_id, "away") }
    lowest_visitor.teamname
  end

  def lowest_scoring_home_team
    lowest_home = teams.min_by { |team| average_goals_per_game_by_id(team.team_id, "home") }
    lowest_home.teamname
  end


  def game_is_in_season(season, game_id)
    # @games.any? { |game| game.season == season && game.game_id == game_id }
    @games.any? do |game|
      game.season == season && game.game_id == game_id
      require "pry"; binding.pry
    end

  end

  def total_tackles_by_team_id(team_id)
    games_by_team_id(team_id).sum do |game|
      if game_is_in_season(season, game_id)
        puts "counts tackles"
        game.tackles
      else
        puts "doesnt count"
        0
      end
    end
  end


  def most_tackles(season)
    most_tackles = @teams.max_by { |team| total_tackles_by_team_id(season) } #team.team_id
    most_tackles.teamname
  end

end

# if season == nil
#   game.tackles
# else
  # require "pry"; binding.pry


  # def ids_in_given_season(season)
  #  away_team_ids = @games.map do |game|
  #     if game.season == season
  #       [game.away_team_id, game.home_team_id]
  #     end
  #   end
  #   flat_away_team_ids = away_team_ids.flatten.uniq.compact
  # end
