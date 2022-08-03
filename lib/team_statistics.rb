require_relative 'team_stats_module'
require_relative 'global_module'
class TeamStatistics
    include Teamable
    include Globeable


    def initialize(teams_data, games_data, game_teams_data)
      @teams_data = teams_data
      @games_data = games_data
      @game_teams_data = game_teams_data
    end

    def team_info(given_team_id)

      all_team_info = @teams_data.select do |team|
        team[:team_id].to_s == given_team_id.to_s
      end[0]

      team_info_hash = {
        "abbreviation" => all_team_info[:abbreviation],
        "franchise_id" => all_team_info[:franchiseid],
        "link" => all_team_info[:link],
        "stadium" => all_team_info[:stadium],
        "team_id" => all_team_info[:team_id],
        "teamname" => all_team_info[:teamname],
      }
    end

    def fewest_goals_scored(given_team_id)
      goals_scored_by_game(given_team_id).min
    end

    def most_goals_scored(given_team_id)
        goals_scored_by_game(given_team_id).max
    end

    def worst_season(given_team_id)
      season_record(given_team_id).min_by { |season, record| record[0] / (record[2] + record [1]) }.first
    end

    def best_season(given_team_id)
      season_record(given_team_id).max_by { |season, record| record[0] / (record[2] + record [1]) }.first
    end

    def average_win_percentage(given_team_id)
      overall_record = season_record(given_team_id).values.transpose.map(&:sum)
      find_percentage(overall_record[0], (overall_record[0..2].sum))
    end

    def rival(given_team_id)
      wins_and_losses = head_to_head_records(given_team_id)
      rival_array = wins_and_losses.min_by { |team, array| (array[0] - array [1])}
      find_team_name_by_id(rival_array[0])
    end

    def favorite_opponent(given_team_id)
      wins_and_losses = head_to_head_records(given_team_id)
      fav_opponent_array = wins_and_losses.max_by { |team, array| (array[0] - array [1])}
      find_team_name_by_id(fav_opponent_array[0])
    end
end