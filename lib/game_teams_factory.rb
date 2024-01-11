require 'csv'

class GameTeamFactory

        attr_reader :file_path

        def initialize(file_path)
            @file_path = file_path
        end

        def create_game_team 
            game_team = []
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

                game_team << GameTeam.new(game_team_info)
            end
            game_team
        end

end
