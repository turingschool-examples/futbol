require 'csv'
require_relative 'team.rb'

class LeagueStats < Team
  attr_reader :game_teams, 
              :games 

  def initialize(file_1, file_2)
    @game_teams = self.format(file_1)
    @teams      = self.format2(file_2)
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
end