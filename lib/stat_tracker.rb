require 'CSV'
require './lib/game.rb'
require './lib/team.rb'
require './lib/game_team.rb'
require './lib/game_stats'
require './lib/league_stats'
require './lib/season_stats'

class StatTracker
    include GameStats
    include LeagueStats
    include SeasonStats
    def initialize(locations)
        @games = []
        CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
            @games << Game.new(row[:season], row[:away_team_id], row[:home_team_id], row[:away_goals], row[:home_goals])
        end
        @teams = []
        CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
            @teams << Team.new(row[:team_id], row[:teamName])
        end
        @game_teams = []
        CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
            @game_teams << GameTeam.new(row[:team_id], row[:HoA], row[:result], row[:head_coach], row[:goals], row[:shots], row[:tackles])
        end
    end

    def self.from_csv(locations)
        self.new(locations)
    end
end