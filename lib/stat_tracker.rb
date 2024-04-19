require 'CSV'
require_relative './game.rb'
require_relative './team.rb'
require_relative './game_team.rb'
require_relative './game_stats'
require_relative './league_stats'
require_relative './season_stats'

class StatTracker
    attr_reader :games, :teams, :game_teams
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
            @teams << Team.new(row[:team_id], row[:teamname])
        end
        @game_teams = []
        CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
            @game_teams << GameTeam.new(row[:game_id], row[:team_id], row[:hoa], row[:result], row[:head_coach], row[:goals], row[:shots], row[:tackles])
        end
    end

    def self.from_csv(locations)
        self.new(locations)
    end
end