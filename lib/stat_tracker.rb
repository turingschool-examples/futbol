require 'csv'

class StatTracker
    def self.from_csv(locations)
        #iterate through each hash key/value pair
        locations.each do |file_name, file_path|
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
                    @game = Game.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue)
                elsif file_name == :teams
                    team_id = row[:team_id]
                    franchise_id = row[:franchise]
                    abbreviation = row[:abbreviation]
                    stadium = row[:stadium]
                    @team = Team.new(team_id, franchise_id, abbreviation, stadium)
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
                    #game_teams arguments needed
                    @game_team = GameTeam()
                else
                    puts "I don't have access to #{file_name}, sorry."
                end
            end
        end
    end
end