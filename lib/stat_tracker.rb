require_relative './CSV'
require_relative './game'
require_relative './team'
require_relative './game_team'

class StatTracker
    attr_reader :games, :teams, :game_teams

    def initialize
        @games = []
        @teams = []
        @game_teams = []
    end

    def self.from_csv(info)
        data_collect = StatTracker.new
        data_collect.games = StatTracker.game_factory(info)
        data_collect.teams = StatTracker.team_factory(info)
        data_collect.game_teams = StatTracker.game_team_factory(info)
    end

    def self.game_factory(info)
        games = []
        CSV.foreach(info[:games], headers: true, header_converters: :symbol) do |row|
            class_info = {:game_id => row[:game_id],
            :season => row[:season],
            :type => row[:type],
            :date_time => row[:date_time],
            :away_team_id => row[:away_team_id],
            :home_team_id => row[:home_team_id],
            :away_goals => row[:away_goals],
            :home_goals => row[:home_goals],
            :venue => row[:venue],
            :venue_link => row[:venue_link]}
            games << Game.new(class_info)
        end
        games
    end
       
    def self.team_factory(info)
        teams = []
        CSV.foreach(info[:teams], headers: true, header_converters: :symbol) do |row|
            class_info = {:team_id => row[:team_id],
            :franchise_id => row[:franchiseId],
            :team_name => row[:teamName],
            :abbreviation => row[:abbreviation],
            :stadium => row[:Stadium],
            :link => row[:link]}
            teams << Team.new(class_info)
        end
        teams
    end
        
    def self.game_team_factory(info)
        game_teams = []
        CSV.foreach(info[:game_teams], headers: true, header_converters: :symbol) do |row|
            class_info = {:game_id => row[:game_id],
            :team_id => row[:team_id],
            :hoa => row[:HoA],
            :result => row[:result],
            :settled_in => row[:settled_in],
            :head_coach => row[:head_coach],
            :goals => row[:goals],
            :shots => row[:shots],
            :tackles => row[:tackles],
            :pim => row[:pim],
            :power_play_opportunities => row[:powerPlayOpportunities],
            :power_play_goals => row[:powerPlayGoals],
            :face_off_win_percentage => row[:faceOffWinPercentage],
            :giveaways => row[:giveaways],
            :takeaways => row[:takeaways]}
            game_teams << GameTeam.new(class_info)
        end
        game_teams
    end
end