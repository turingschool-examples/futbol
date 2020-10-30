require_relative './season'

class SeasonsCollection
  attr_reader :seasons

  def initialize(game_teams_path, season_ids, team_ids, parent)
    @team_ids = team_ids
    @season_ids = season_ids
    @parent = parent
    @seasons = []
    create_seasons(game_teams_path)
  end

  def create_seasons(file_path)
    seasons_by_team = seasons_by_team(file_path)
    seasons_by_team.map do |team_id, seasons|
      seasons.each do |season_id, game_teams_data|
        @seasons << Season.new(team_id, season_id, game_teams_data, self)
      end
    end
  end

  def seasons_by_team(file_path)
    seasons_by_team = map_seasons_by_team
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      season = find_season_id(row[:game_id])
      seasons_by_team[row[:team_id]][season] << row.to_h
    end
    seasons_by_team
  end

  def map_seasons_by_team
    @team_ids.each_with_object({}) do |team_id, seasons_hash|
      seasons_hash[team_id] = @season_ids.each_with_object({}) do |season, new_hash|
        new_hash[season] = []
      end
    end
  end

  def find_season_id(game_id)
    @parent.find_season_id(game_id)
  end
end
