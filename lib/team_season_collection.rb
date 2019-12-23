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
    from_csv(csv_file_path).reduce(Hash.new({})) do |hash, row|
      season_hash = Hash.new([])
      season_hash[row[:season]] += [collection_type.new(row)]

      collection_helper_away(row, hash, season_hash)

      collection_helper_home(row, hash, season_hash)

      require 'pry'; binding.pry

      hash
    end
  end
end
