require 'csv'

# game_data = CSV.open"./data/games.csv", headers: true, header_converters: :symbol

class StatTracker
  attr_reader :games, :teams, :game_teams

  def initialize(locations)
    @games = CSV.read "#{locations[:games]}", headers: true, header_converters: :symbol
    @teams = CSV.read "#{locations[:teams]}", headers: true, header_converters: :symbol
    @game_teams = CSV.read "#{locations[:game_teams]}", headers: true, header_converters: :symbol
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    game_score = []
    @games.each do |row|
      game_score << row[:away_goals].to_i + row[:home_goals].to_i
    end
    game_score.max
  end

  def team_info(team_id)
    # require "pry"; binding.pry
    team = Hash.new

    @teams.each do |row|
      if row[:team_id] == team_id.to_s
        team[:team_id] = row[:team_id]
        team[:franchise_id] = row[:franchiseid]
        team[:team_name] = row[:teamname]
        team[:abbreviation] = row[:abbreviation]
        team[:link] = row[:link]
      end
    end
    # require "pry";binding.pry
    return team
  end
end


## -- Old Team info Method attempts -- ##
    # @teams.find do |row|
    #   team_id = row[:team_id]
    #   franchise_id = row[:franchiseid]
    #   team_name = row[:teamname]
    #   abbrev = row[:abbreviation]
    #   link = row[:link]
    #   team << Hash.new(team_id, franchise_id, team_name, abbrev, link)
      # :team_id => @teams[:team_id],
      # :franchise_id => @teams[:franchiseid],
      # :team_name => @teams[:teamname],
      # :abbrev => @teams[:abbreviation],
      # :link => @teams[:link]
