require_relative './season'

class SeasonsCollection
  attr_reader :seasons

  def initialize(filepath, season_ids, team_ids, parent)
    @parent     = parent
    @team_ids   = team_ids
    @season_ids = season_ids
    @seasons    = []
    create_seasons(filepath)
  end

  def create_seasons(filepath)
    seasons_by_team = seasons_by_team(filepath)
    seasons_by_team.each do |team_id, seasons|
      seasons.each do |season_id, games_teams|
        @seasons << Season.new(team_id, season_id, games_teams, self)
      end
    end
  end

  def seasons_by_team(filepath)
    seasons_by_team = map_seasons_by_team
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      season = find_season_id(row[:game_id])
      seasons_by_team[row[:team_id]][season] << row.to_h
    end
    seasons_by_team
  end

  def map_seasons_by_team
      @team_ids.each_with_object({}) do |team_id, teams_hash|
        teams_hash[team_id] = @season_ids.each_with_object({}) do |season, seasons_hash|
          seasons_hash[season] = []
        end
      end
  end

  def find_season_id(game_id)
    @parent.find_season_id(game_id)
  end

  def total_goals_by_team
    goals_by_team = Hash.new(0)
    @seasons.each do |season|
      goals_by_team[season.team_id] += season.total_goals
    end
    goals_by_team
  end

  def total_games_by_team
    games_by_team = Hash.new(0)
    @seasons.each do |season|
      games_by_team[season.team_id] += season.total_games
    end
    games_by_team
  end

  def best_offense
    average = total_goals_by_team.merge(total_games_by_team) do |team_id, total_goals, total_games|
      (total_goals.to_f / total_games).round(2)
    end
    best = average.max_by do |team_id, avg|
      avg
    end
    find_team_name(best[0])
  end

  def find_team_name(team_id)
    @parent.find_by_id(team_id)
  end
end
