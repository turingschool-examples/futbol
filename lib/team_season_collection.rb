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

      require 'pry'; binding.pry

      if !hash.empty? && hash.has_key?(key)
        data = hash[key].values.flatten!
        hash[key] = { row[:season] => (data << season_data).flatten! }
      elsif hash.empty? || !hash.has_key?(key)
        hash[key] = { row[:season] => (hash[key].values << season_data).flatten! }
      end

      require 'pry'; binding.pry

      season_hash = { row[:away_team_id] => { row[:season] => [] } }
      season_hash[row[:away_team_id]] = { row[:season] => (season_hash[row[:away_team_id]][row[:season]] += [collection_type.new(row)]) }
      season_data = season_hash[row[:away_team_id]].values.flatten!
      key = season_hash.keys[0]

      require 'pry'; binding.pry

      if !hash.empty? && hash.has_key?(key)
        data = hash[key].values.flatten!
        hash[key] = { row[:season] => (data << season_data).flatten! }
      elsif hash.empty? || !hash.has_key?(key)
        hash[key] = { row[:season] => (hash[key].values << season_data).flatten! }
      end
      require 'pry'; binding.pry
      hash
    end
  end
end

# hash.keys[0] = hash[row[:home_team_id]].keys[0] = (hash[row[:home_team_id]][row[:season]] += season_hash[row[:home_team_id]][row[:season]])