require_relative 'csv_reader'
require_relative 'game_teams'


class GameTeamStats < CSVReader

    def initialize
        super(locations)
    end
# Team Statistics
    def team_by_id(team_id)
        # require 'pry'; binding.pry
        @game_teams.find_all { |team| team.team_id == team_id }
    end

    def season_games(game_id)
        season = ""
        @games.find do |game|
            if game_id[0..3] == game.season[0..3]
                season << game.season
            end
        end
        return season
    end

    def sorting_by_season_win_percentage(team_id)
        games_by_season = team_by_id(team_id).group_by { |game| season_games(game.game_id) }
        win_tracker = 0.0
        games_by_season.map do |season, games|
            games.each do |game|
                win_tracker += 1.0 if game.result == "WIN"
            end
        win_percentage = win_tracker / games.count * 100
        games_by_season[season] = win_percentage
        win_tracker = 0.0
        end
        games_by_season
    end

    def best_season(team_id)
        sorting_by_season_win_percentage(team_id).max_by {|season, percentage| percentage}[0]
    end

    def worst_season(team_id)
        sorting_by_season_win_percentage(team_id).min_by {|season, percentage| percentage}[0]
    end

    # def average_win_percentage(team_id)
    #     team_by_id(team_id)
    #     win_counter = 0.0
    #     win_loss_tracker = team_by_id.map {|team| team.result}
    #     win_loss_tracker.each do |result|
    #     if result == ('WIN')
    #         win_counter += 1
    #     end
    #     end
    #     percentage = win_counter / win_loss_tracker.count
    #     percentage.round(2)
    # end

    # def most_goals_scored(team_id)
    #     team_by_id(team_id)
    #     highest_goals = team_by_id.map do |id|
    #     id.goals
    #     end
    #     highest_goals.sort.pop
    #     # require 'pry'; binding.pry
    # end

    # def fewest_goals_scored(team_id)
    #     team_by_id(team_id)
    #     highest_goals = team_by_id.map do |id|
    #     id.goals
    #     end
    #     highest_goals.sort.shift
    # end

    # def favorite_opponent(team_id)
    #     team_by_id(team_id)
    #     id_of_every_game_played = team_by_id.flat_map {|game_team| game_team.game_id}
    #     opponents = @game_teams.find_all do |game_team|
    #     id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id
        # end
        # teams_by_id = opponents.group_by {|opponent| opponent.team_id}
        # # require 'pry'; binding.pry
        # opposing_win = 0.0
        # teams_by_id.each do |team_id, game_teams|
        # game_teams.each do |game_team|
        #     if game_team.result == 'WIN'
        #     opposing_win += 1
        #     end
        # end
        # opposing_win_percentage = opposing_win / game_teams.count
        # teams_by_id[team_id] = opposing_win_percentage
    #     opposing_win = 0.0 
    #     end
    #     favorite = teams_by_id.min_by {|team_id, win_percentage| win_percentage}[0]
    #     @teams.each do |team| 
    #     if team.team_id.include?(favorite)
    #         return team.team_name
    #     end
    #     end
    #     # require 'pry'; binding.pry
    # end

    # def rival(team_id)
    #     team_by_id(team_id)
    #     id_of_every_game_played = team_by_id.flat_map {|game_team| game_team.game_id}
    #     opponents = @game_teams.find_all do |game_team|
        # id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id
        # end
        # teams_by_id = opponents.group_by {|opponent| opponent.team_id}
        # # require 'pry'; binding.pry
        # opposing_win = 0.0
        # teams_by_id.each do |team_id, game_teams|
        # game_teams.each do |game_team|
        #     if game_team.result == 'WIN'
        #     opposing_win += 1
        #     end
        # end
        # opposing_win_percentage = opposing_win / game_teams.count
        # teams_by_id[team_id] = opposing_win_percentage
        # opposing_win = 0.0 
#         end
#         least_favorite = teams_by_id.max_by {|team_id, win_percentage| win_percentage}[0]
#         @teams.each do |team|
#         if team.team_id.include?(least_favorite)
#             return team.team_name
#         end
#         end
#     end
#     end
end