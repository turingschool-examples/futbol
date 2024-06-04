require 'csv'

class StatTracker
    def initialize(game_path, team_path, game_teams_path)

    end

    def self.from_csv(locations)
        game_path = CSV.read(locations[:games])
        team_path = CSV.read(locations[:teams])
        game_teams_path = CSV.read(locations[:game_teams])

        StatTracker.new(game_path, team_path, game_teams_path)
    end
end

# def self.create_muliple_objects(path)   This doesn't go here, will go with classes to break out each csv file
#     teams = []
#     CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
#         teams << StatTracker.new(team header info, would break this out?) team_id,franchiseId,teamName,abbreviation,Stadium,link
#     end
# end

# games.csv would be (game_id,season,type,date_time,away_team_id,home_team_id,away_goals,home_goals,venue,venue_link)
# games_teams.csv would be (game_id,team_id,HoA,result,settled_in,head_coach,goals,shots,tackles,pim,powerPlayOpportunities,powerPlayGoals,faceOffWinPercentage,giveaways,takeaways)
