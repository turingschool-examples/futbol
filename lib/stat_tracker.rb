# require_relative './spec_helper'
 require_relative './game'
 require_relative './game_team'
 require_relative './teams'


class StatTracker
  attr_reader :locations, :team_data, :game_data, :game_teams_data
  
  def initialize(locations)
    @game_data = create_games(locations[:games])
    # require 'pry'; binding.pry
    @game_teams_data = create_game_teams(locations[:game_teams])
    # require 'pry'; binding.pry
    @team_data = create_teams(locations[:teams])
    # require 'pry'; binding.pry
    # @locations = locations 
    # @game_data = CSV.read locations[:games], headers: true, header_converters: :symbol
    #@teams_data = CSV.read locations[:teams], headers: true, header_converters: :symbol
    #@game_team_data = CSV.read locations[:game_teams], headers: true, header_converters: :symbol
  end
  
  def create_games(path)
    # require 'pry'; binding.pry
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    # data.map { |row| Game.new(row) } 
    data.map do |row|
    Game.new(row)
    end
  end
  
  def create_game_teams(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |row| 
      # require 'pry'; binding.pry
    GameTeam.new(row)
    end
  end

  def create_teams(path)
    data = CSV.parse(File.read(path), headers: true, header_converters: :symbol)
    data.map do |row|
      Team.new(row)
    end
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end
  
  def percentage_calculator(portion, whole)
    percentage = (portion/whole).round(2)
  end
  
  def percentage_ties 
    ties = @game_data.count do |game|
      # require 'pry'; binding.pry
      game.away_goals.to_f == game.home_goals.to_f
    end.to_f
    (ties/@game_data.count).round(2)
  end

  def average_goals_per_game
    total_goals = 0
    total_games = []
    @game_teams_data.each do |row|
      # require 'pry'; binding.pry
      total_goals += row.goals.to_i
      total_games << row.game_id
    end
    average = total_goals.to_f / total_games.uniq.count
    average.round(2)
  end

  def team_goals
    teams = @game_teams_data.group_by { |row| row.team_id}
    team_goals = Hash.new(0)
    teams.each do |team, data_array|
      goals = 0
      data_array.each do |data|
        goals += data.goals.to_i
      end
      team_goals[team] = goals
    end
    team_goals
  end
  
  
  def games_by_team(home_or_away)
    teams = @game_teams_data.group_by { |row| row.team_id }
    # require 'pry'; binding.pry
    games = Hash.new
    teams.each do |team, data_array|
      game_location = data_array.select { |data| data.hoa == home_or_away }
      games[team] = game_location.count
    end
    games
  end
end


# combine both of these into one
# def home_games_by_team
#   teams = @game_teams_data.group_by { |row| row.team_id}
#   games_at_home = Hash.new(0)
#   teams.each do |team, data_array|
#     home_games = []
#     data_array.each do |data|
#       if data.hoa == "home"
#       home_games << data.game_id
#       end
#     end
#     games_at_home[team] = home_games.count
#   end
#   games_at_home
# end

# def away_games_by_team
#   teams = @game_teams_data.group_by { |row| row.team_id}
#   games_not_at_home = Hash.new(0)
#   teams.each do |team, data_array|
#     away_games = []
#     data_array.each do |data|
#       if data.hoa == "away"
#       away_games << data.game_id
#       end
#     end
#     games_not_at_home[team] = away_games.count
#   end
#   games_not_at_home
# end


