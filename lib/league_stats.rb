require 'csv'
require_relative 'team.rb'

class LeagueStats < Team
  attr_reader :game_teams, 
              :games 

  def initialize(file_1, file_2, file_3)
    @game_teams = self.format(file_1)
    @teams      = self.format2(file_2)
    @games      = self.format3(file_3)
  end 

  def format(file)
    league_file = CSV.read(file, headers: true, header_converters: :symbol)
    league_file.map do |row|
      Team.new(row)
    end
  end

  def format2(file)
    league_file = CSV.read(file, headers: true, header_converters: :symbol)
    league_file.map do |row|
      Teams.new(row)
    end
  end

  def format3(file)
    league_file = CSV.read(file, headers: true, header_converters: :symbol)
    league_file.map do |row|
      Game.new(row)
    end
  end

  def count_of_teams
    @game_teams.count
  end

  def find_team_name(team_id)
    @teams.find do |team|
      if team.team_id == team_id
        return team.teamname
      end
    end
  end

  def total_goals(team_id)
    goals = 0
    @game_teams.each do |team|
      if team.team_id == team_id
        goals += (team.goals.to_i)
      end
    end
    goals.to_f
  end

  def total_games(team_id)
    games = []
    @game_teams.each do |game|
      if game.team_id == team_id
        games << game.game_id
      end
    end
    games.uniq.count
  end

  def best_offense 
   averages = @game_teams.reduce({}) do |hash, team|
      hash[team.team_id] = ((total_goals(team.team_id)) / (total_games(team.team_id))).round(2)
      hash
    end
    averages
    find_team_name(averages.key(averages.values.max))
  end

  def worst_offense 
   averages = @game_teams.reduce({}) do |hash, team|
      hash[team.team_id] = ((total_goals(team.team_id)) / (total_games(team.team_id))).round(2)
      hash
    end
    averages
    find_team_name(averages.key(averages.values.min))
  end
  
  def away_teams_list
   @game_teams.find_all do |game|
      game.hoa == "away"
    end
  end

  def home_teams_list
   @game_teams.find_all do |game|
      game.hoa == "home"
    end
  end

  def highest_scoring_visitor
    scores = away_teams_list.reduce({}) do |hash, team|
      hash[team.team_id] = team.goals.to_i
      hash
    end
    find_team_name(scores.key(scores.values.max))
  end

  def lowest_scoring_visitor
    scores = away_teams_list.reduce({}) do |hash, team|
      hash[team.team_id] = team.goals.to_i
      hash
    end
    find_team_name(scores.key(scores.values.min))
  end

  def highest_scoring_home_team
    scores = home_teams_list.reduce({}) do |hash, team|
      hash[team.team_id] = team.goals.to_i
      hash
    end
    find_team_name(scores.key(scores.values.max))
  end

  def lowest_scoring_home_team
    scores = home_teams_list.reduce({}) do |hash, team|
      hash[team.team_id] = team.goals.to_i
      hash
    end
    find_team_name(scores.key(scores.values.min))
  end
end