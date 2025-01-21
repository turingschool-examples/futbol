require 'csv'
require 'pry'

class CSVHelper

    def self.teamsCSV(filepath)
        teams = []
        CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
            teams << Team.new(
                row[:team_id].to_i,
                row[:franchiseid].to_i,
                row[:teamname],
                row[:abbreviation],
                row[:stadium],
                row[:link]
            )
        end
        teams
    end

    def self.gamesCSV(filepath)
        games = []
        CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
            games << Game.new(
                row[:game_id].to_i,
                row[:season].to_i,
                row[:type],
                row[:date_time],
                row[:away_team_id].to_i,
                row[:home_team_id].to_i,
                row[:away_goals].to_i,
                row[:home_goals].to_i,
                row[:venue],
                row[:venue_link]
            )
        end
        games
    end

    def self.game_teamsCSV(filepath)
        game_teams = []
        CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
            game_teams << GameTeam.new(
                row[:game_id].to_i,
                row[:team_id].to_i,
                row[:hoa],
                row[:result],
                row[:settled_in],
                row[:head_coach],
                row[:goals].to_i,
                row[:shots].to_i,
                row[:tackles].to_i,
                row[:pim].to_i,
                row[:powerplayopportunities].to_i,
                row[:powerplaygoals].to_i,
                row[:faceoffwinpercentage].to_f,
                row[:giveaways].to_i,
                row[:takeaways].to_i
            )
        end
        game_teams
    end
end