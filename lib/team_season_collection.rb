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
      # require 'pry'; binding.pry
      # season_hash = { row[:home_team_id] => { row[:season] => ([] << collection_type.new(row)) } }
      hash[row[:home_team_id]] = { row[:season] => (hash[row[:home_team_id]][row[:season]] += [collection_type.new(row)]) }
      hash[row[:away_team_id]] = { row[:season] => (hash[row[:away_team_id]][row[:season]] += [collection_type.new(row)]) }
      # nest1 = season_hash.dig(row[:home_team_id])
      # nest2 = season_hash.dig(row[:home_team_id], row[:season])
      # require 'pry'; binding.pry
      # hash.merge!(season_hash){ |k, old_val, new_val| hash[k] = nest1.keys[0] = old_val.append(new_val) }
      # require 'pry'; binding.pry
      hash
    end
  end
end
