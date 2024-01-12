require 'csv'
# require_relative './lib/game'
# require_relative './lib/team'
# require_relative './lib/game_team'

class StatTracker
    attr_reader :games,
                :teams,
                :game_teams

    def initialize(locations)
        @games = []
        @teams = []
        @game_teams = []
    end
    # class method for StatTracker
    def self.from_csv(locations)
        #iterate through each hash key/value pair (key elements -> file_name, value elements -> file_path)
        locations.each do |file_name, file_path|

            #for each hash value (file_path) goes through and converts the row to be another hash with the column headers as keys and the row values as the key's values.
            CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
                if file_name == :games
                    game_id = row[:game_id]
                    season = row[:season]
                    type = row[:type]
                    date_time= row[:date_time]
                    away_team_id = row[:away_team_id]
                    home_team_id = row[:home_team_id]
                    away_goals = row[:away_goals]
                    home_goals = row[:home_goals]
                    venue = row[:venue]
                    game = Game.new(row)#game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue)
                    @games << game
                elsif file_name == :teams
                    team_id = row[:team_id]
                    franchise_id = row[:franchise]
                    abbreviation = row[:abbreviation]
                    stadium = row[:stadium]
                    @teams << team = Team.new(row)#team_id, franchise_id, abbreviation, stadium)
                elsif file_name == :game_teams
                    game_id = row[:game_id]
                    team_id = row[:team_id]
                    home_or_away_game = row[:HoA]
                    result = row[:res]
                    settled_in = row[:settled_in]
                    head_coach = row[:head_coach]
                    goals = row[:goals]
                    shots = row[:shots]
                    tackles = row[:tackles]
                    pentalty_infraction_min = row[:pim]
                    power_play_opportunities = row[:powerPlayOpportunities]
                    power_play_goals = row[:powerPlayGoals]
                    face_off_win_percentage = row[:faceOffWinPercentage]
                    give_aways = row[:giveaways]
                    take_aways = row[:takeaway]
                    game_team = GameTeam(game_id, team_id, home_or_away_game, result, settled_in, head_coach, goals, shots, tackles, pentalty_infraction_min, power_play_opportunities, power_play_goals, face_off_win_percentage, give_aways, take_aways)
                    @game_teams << game_team
                else
                    puts "I don't have access to #{file_name}, sorry."
                end
            end
        end
    end



    def percentage_home_wins

        total_home_wins = @games.count do |game|
            game.home_goals > game.away_goals
        end
        (total_home_wins.to_f / @games.size).round(2)
    end

    def percentage_visitor_wins

        total_home_wins = @games.count do |game|
            game.home_goals < game.away_goals
        end
        (total_home_wins.to_f / @games.size).round(2)
    end

    def percentage_ties
        total_ties = @games.count do |game|
          game.home_goals == game.away_goals
        end
        (total_ties.to_f / @games.size).round(2)

    end

    def count_of_games_by_season def
        season_counts = Hash.new(0)
        @games.each do |game|
            season = game.season
            season_counts[season] += 1
          end
          season_counts
        end
    end
end
