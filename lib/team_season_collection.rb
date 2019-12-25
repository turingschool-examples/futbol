require_relative 'team_season'
require_relative 'season_collection'
require_relative './modules/gatherable'
require 'csv'

class TeamSeasonCollection < Collection
  include Gatherable

  def initialize(csv_file_path)
    super(csv_file_path, TeamSeason)
  end

  def home_id_parse(row, collection_type, home_id, hash)
    season_hash = team_hash(row, home_id)
    season_hash = team_season_hash(row, collection_type, season_hash, home_id)
    season_data = season_data_array(season_hash, home_id)
    key = team_key(season_hash)
    season_key = season_key(season_hash, key)
    hash = season_parse(key, season_key, season_data, hash)
  end

  def away_id_parse(row, collection_type, away_id, hash)
    season_hash = team_hash(row, away_id)
    season_hash = team_season_hash(row, collection_type, season_hash, away_id)
    season_data = season_data_array(season_hash, away_id)
    key = team_key(season_hash)
    season_key = season_key(season_hash, key)
    hash = season_parse(key, season_key, season_data, hash)
  end

  def create_collection(csv_file_path, collection_type)
    from_csv(csv_file_path).reduce(Hash.new(Hash.new([]))) do |hash, row|
      home_id = row[:home_team_id]
      away_id = row[:away_team_id]

      hash = home_id_parse(row, collection_type, home_id, hash)
      hash = away_id_parse(row, collection_type, away_id, hash)

      hash
    end
  end
end
