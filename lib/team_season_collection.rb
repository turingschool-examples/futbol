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
      season_hash = { row[:home_team_id] => { row[:season] => [] } }
      season_hash[row[:home_team_id]] = { row[:season] => (season_hash[row[:home_team_id]][row[:season]] += [collection_type.new(row)]) }
      season_data = season_hash[row[:home_team_id]].values.flatten!
      key = season_hash.keys[0]
      season_key = season_hash[key].keys[0]

      if hash.key?(key) && hash[key].has_key?(season_key)
        data = hash[key].values.flatten!
        hash[key][season_key] << season_data
      elsif hash.key?(key) && !hash[key].has_key?(season_key)
        data = hash[key].values.flatten!
        { hash[key] => hash[key][season_key] = season_data }
      elsif !hash.has_key?(key) && !hash.empty?
        hash[key] = { season_key => season_data }
      elsif hash.empty?
        hash = { key => { season_key => season_data } }
      end

      season_hash = { row[:away_team_id] => { row[:season] => [] } }
      season_hash[row[:away_team_id]] = { row[:season] => (season_hash[row[:away_team_id]][row[:season]] += [collection_type.new(row)]) }
      season_data = season_hash[row[:away_team_id]].values.flatten!
      key = season_hash.keys[0]
      season_key = season_hash[key].keys[0]

      if hash.key?(key) && hash[key].has_key?(season_key)
        data = hash[key].values.flatten!
        hash[key][season_key] << season_data
      elsif hash.key?(key) && !hash[key].has_key?(season_key)
        data = hash[key].values.flatten!
        { hash[key] => hash[key][season_key] = season_data }
      elsif !hash.has_key?(key) && !hash.empty?
        hash[key] = { season_key => season_data }
      elsif hash.empty?
        hash = { key => { season_key => season_data } }
      end
      hash
    end
  end
end

# { hash[key] => hash[key][season_key] = season_data }