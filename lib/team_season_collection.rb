require_relative 'team_season'
require_relative 'season_collection'
require_relative './modules/gatherable'
require 'csv'

class TeamSeasonCollection < Collection
  include Gatherable

  def initialize(csv_file_path)
    super(csv_file_path, TeamSeason)
  end

  def create_collection(csv_file_path, collection_type)
    from_csv(csv_file_path).reduce(Hash.new(Hash.new([]))) do |hash, row|
      home_id = row[:home_team_id]
      away_id = row[:away_team_id]

      season_hash = team_hash(row, home_id)
      season_hash = team_season_hash(row, collection_type, season_hash, home_id)
      season_data = season_data_array(row, season_hash, home_id)
      key = team_key(season_hash)
      season_key = season_key(season_hash, key)
      hash = season_parse(key, season_key, season_hash, season_data, hash)

      season_hash = team_hash(row, away_id)
      season_hash = team_season_hash(row, collection_type, season_hash, away_id)
      season_data = season_data_array(row, season_hash, away_id)
      key = team_key(season_hash)
      season_key = season_key(season_hash, key)
      hash = season_parse(key, season_key, season_hash, season_data, hash)

      hash
    end
  end
end
