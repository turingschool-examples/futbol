require 'csv'

class GameTeamFactory

    attr_reader :file_path

    def initialize(file_path)
        @file_path = file_path
        @game_teams = []
    end

    def create_game_team 
        CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
            game_team_info = {}
            game_team_info[:game_id] = row[:game_id].to_i
            game_team_info[:team_id] = row[:team_id].to_i
            game_team_info[:hoa] = row[:hoa]
            game_team_info[:result] = row[:result]
            game_team_info[:settled_in] = row[:settled_in]
            game_team_info[:head_coach] = row[:head_coach]
            game_team_info[:goals] = row[:goals].to_i
            game_team_info[:shots] = row[:shots].to_i
            game_team_info[:tackles] = row[:tackles].to_i
            game_team_info[:pim] = row[:pim].to_i
            game_team_info[:power_play_opps] = row[:powerplayopportunities].to_i
            game_team_info[:power_play_goals] = row[:powerplaygoals].to_i
            game_team_info[:faceoff_win_percent] = row[:faceoffwinpercentage].to_f.round(1)
            game_team_info[:giveaways] = row[:giveaways].to_i
            game_team_info[:takeaways] = row[:takeaways].to_i

            @game_teams << GameTeam.new(game_team_info)
        end
        @game_teams
    end


    def ratio_of_shots_to_goals_by_season(season)
        ratios = {}
        @game_teams.each do |game_team|
            if game_team.get_season_from_game_id == season
                ratios[game_team.team_id] = ratio_of_shots_to_goals_by_team(game_team.team_id)
            end
        end
        ratios
    end

    def ratio_of_shots_to_goals_by_team(team_id)
        shots = 0
        goals = 0
        @game_teams.each do |game_team|
            shots += game_team.shots if game_team.team_id == team_id
            goals += game_team.goals if game_team.team_id == team_id
        end
        ((goals.to_f / shots.to_f) * 100).round(2)
    end

    def ratio_of_shots_to_goals
        hash = {}
        @game_teams.each do |game_team|
            hash[game_team.get_season_from_game_id] = ratio_of_shots_to_goals_by_season(game_team.get_season_from_game_id)
        end
        hash
    end


    def game_result_by_hoa
        game_results = []
        @game_teams.each do |game_team|
            game_results << game_team.hoa if game_team.result == "WIN"
        end
        game_results
    end
    
end
# binding.pry


