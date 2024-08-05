require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_team'
require_relative './season_stat'
require_relative './game_stat'
require_relative './league_stat'
require_relative './team_stat'


class StatTracker
    include SeasonStatistics
    include LeagueStatistics
    include GameStat
    include TeamStatistics
    
    attr_reader :games, :teams, :game_teams

    def initialize
        @games = []
        @teams = []
        @game_teams = []
    end

    def self.from_csv(info)
        data_collect = StatTracker.new
        data_collect.games.replace(StatTracker.game_factory(info))
        data_collect.teams.replace(StatTracker.team_factory(info))
        data_collect.game_teams.replace(StatTracker.game_team_factory(info))
        data_collect
    end

    def self.game_factory(info)
        games = []
        CSV.foreach(info[:games], headers: true, header_converters: :symbol) do |row|
            games << Game.new(row)
        end
        games
    end
    
    def self.team_factory(info)
        teams = []
        CSV.foreach(info[:teams], headers: true, header_converters: :symbol) do |row|
            teams << Team.new(row)
        end
        teams
    end
        
    def self.game_team_factory(info)
        game_teams = []
        CSV.foreach(info[:game_teams], headers: true, header_converters: :symbol) do |row|
            game_teams << GameTeam.new(row)
        end
        game_teams
    end
end