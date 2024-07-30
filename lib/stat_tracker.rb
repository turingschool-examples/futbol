require_relative './CSV'

class StatTracker
    attr_reader :games, :teams, :game_teams

    def initialize
        @games = []
        @teams = []
        @game_teams = []
    end

    def self.from_csv(info)
        data_collect = StatTracker.new
        # Read first location
        # for each row create game object and store in array

        CSV.foreach(info[:games], headers: true, header_converters: :symbol) do |row|
            game_id = row[:game_id]
            season = row[:season]
            type = row[:type]
            date_time = row[:date_time]
            away_team_id = row[:away_team_id]
            home_team_id = row[:home_team_id]
            away_goals = row[:away_goals]
            home_goals = row[:home_goals]
            venue = row[:venue]
            venue_link = row[:venue_link]
        end
        # Read second location
        # for each row create team object and store in array
        CSV.foreach(info[:teams], headers: true, header_converters: :symbol) do |row|
            team_id = row[:team_id]
            franchise_id = row[:franchiseId]
            team_name = row[:teamName]
            abbreviation = row[:abbreviation]
            stadium = row[:Stadium]
            link = row[:link]
        end
        # Read last location
        # for each row create game_teams object and store in array
        CSV.foreach(info[:game_teams], headers: true, header_converters: :symbol) do |row|
            game_id = row[:game_id]
            team_id = row[:team_id]
            home_or_away = row[:HoA]
            result = row[:result]
            settled_in = row[:settled_in]
            head_coach = row[:head_coach]
            goals = row[:goals]
            shots = row[:shots]
            tackles = row[:tackles]
            penalty_minutes = row[:pim]
            power_play_ops = row[:powerPlayOpportunities]
            power_play_goals = row[:powerPlayGoals]
            faceoff_win_percent = row[:faceOffWinPercentage]
            giveaways = row[:giveaways]
            takeaways = row[:takeaways]
        end
        data_collect
    end
end