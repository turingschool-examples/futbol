require_relative 'csv_reader'
require_relative 'game_teams'


class GameTeamStats < CSVReader

    def initialize(locations)
        super(locations)
    end

    def team_info(team_id)
        team_hash = {}
        @teams.each do |team|
            if team.team_id == team_id
                team_hash = {
                "team_id" => team.team_id,
                "franchise_id" => team.franchise_id,
                "team_name" => team.team_name,
                "abbreviation" => team.abbreviation,
                "link" => team.link
                }
            end
        end
        team_hash 
    end

    def team_by_id(team_id)
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

    def average_win_percentage(team_id)
        win_counter = 0.0
        win_loss_tracker = team_by_id(team_id).map {|team| team.result}.each do |result|
            win_counter += 1 if result == 'WIN'
        end
        percentage = (win_counter / win_loss_tracker.count).round(2)
    end

    def most_goals_scored(team_id)
        team_by_id(team_id).map { |id| id.goals}.sort.pop
    end

    def fewest_goals_scored(team_id)
        team_by_id(team_id).map { |id| id.goals}.sort.shift
    end

    def team_name(team_id)
        team_name_by_id = @teams.find { |team| team.team_id == team_id }.team_name
    end

    def opponent_hash(team_id)
        id_of_every_game_played = team_by_id(team_id).flat_map {|game_team| game_team.game_id}
        opponents = @game_teams.find_all { |game_team| id_of_every_game_played.include?(game_team.game_id) && game_team.team_id != team_id }
        teams_by_id = opponents.group_by {|opponent| opponent.team_id}
        opposing_win = 0.0
        teams_by_id.each do |team_id, game_teams|
            game_teams.each do |game_team|
                opposing_win += 1 if game_team.result == 'WIN'
            end
        opposing_win_percentage = opposing_win / game_teams.count
        teams_by_id[team_id] = opposing_win_percentage
        opposing_win = 0.0
        end
    end

    def favorite_opponent(team_id)
        team_name(opponent_hash(team_id).min_by {|team_id, win_percentage| win_percentage}[0])
    end

    def rival(team_id)
        team_name(opponent_hash(team_id).max_by {|team_id, win_percentage| win_percentage}[0])
    end
end