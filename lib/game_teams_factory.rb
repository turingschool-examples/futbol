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

    def game_result_by_hoa
        game_results = []
        @game_teams.each do |game_team|
            game_results << game_team.hoa if game_team.result == "WIN"
        end
        game_results
    end

    def goals_by_team_and_hoa(team_id, hoa)
        goals = []
        @game_teams.each do |game_team|
            goals << game_team.goals if game_team.hoa == hoa && game_team.team_id == team_id
        end
        goals
    end

    def win_percentage_by_coach(head_coach)
        wins = 0
        losses = 0
        ties = 0
        @game_teams.each do |game_team|
            wins += 1 if game_team.result == 'WIN' && game_team.head_coach == head_coach
            losses += 1 if game_team.result == 'LOSS' && game_team.head_coach == head_coach
            ties += 1 if game_team.result == 'TIE' && game_team.head_coach == head_coach
        end
        if wins == 0
            0.00
        elsif losses == 0
            100.00
        else
            ((wins.to_f / (wins + losses + ties).to_f) * 100).round(2)
        end
    end

    def win_percentage_by_coach_by_season(season)
        percentages_by_coach = {}
        @game_teams.each do |game_team|
            if game_team.get_season_from_game_id == season
                percentages_by_coach[game_team.head_coach] = win_percentage_by_coach(game_team.head_coach)
            end
        end
        percentages_by_coach
    end

    def find_coaches_win_percentages
        coaches_win_percentages = {}
        @game_teams.each do |game_team|
            coaches_win_percentages[game_team.get_season_from_game_id] = win_percentage_by_coach_by_season(game_team.get_season_from_game_id)
        end
        coaches_win_percentages
    end
end

