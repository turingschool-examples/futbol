require 'csv'
class StatTracker
    attr_reader :games, :teams, :game_teams
    def initialize(games, teams, game_teams)
       @games = games
       @teams = teams
       @game_teams = game_teams
    end

    
   
    def self.from_csv(locations)
        games = CSV.read(locations[:games], headers: true, header_converters: :symbol).map do |row|
            {
                game_id: row[:game_id].to_i,
                season: row[:season],  
                type: row[:type],  
                date_time: row[:date_time],   
                away_team_id: row[:away_team_id].to_i,
                home_team_id: row[:home_team_id].to_i,
                away_goals: row[:away_goals].to_i,
                home_goals: row[:home_goals].to_i,
                venue: row[:venue],  
                venue_link: row[:venue_link]  
              }
        end
        teams = CSV.read(locations[:teams], headers: true, header_converters: :symbol).map do |row|

            {
                team_id: row[:team_id].to_i,
                franchiseid: row[:franchiseid].to_i,
                teamname: row[:teamname],
                abbreviation: row[:abbreviation],
                stadium: row[:stadium],
                link: row[:link]
              }
        end
        game_teams = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol).map do |row|
            {
                game_id: row[:game_id].to_i,
                team_id: row[:team_id].to_i,
                hoa: row[:hoa],
                result: row[:result],
                settled_in: row[:settled_in],
                head_coach: row[:head_coach],
                goals: row[:goals].to_i,
                shots: row[:shots].to_i,
                tackles: row[:tackles].to_i,
                pim: row[:pim].to_i,
                powerplayopportunities: row[:powerplayopportunities].to_i,
                powerplaygoals: row[:powerplaygoals].to_i,
                faceoffwinpercentage: row[:faceoffwinpercentage].to_f,
                giveaways: row[:giveaways].to_i,
                takeaways: row[:takeaways].to_i
              }
        end
        
        new(games, teams, game_teams)
    end
end