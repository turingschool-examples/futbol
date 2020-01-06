require_relative 'game_teams'
require_relative 'collection'
require 'csv'

class GameTeamsCollection < Collection
  def initialize(csv_file_path)
    super(csv_file_path, GameTeams)
  end

  def create_collection(csv_file_path, collection_type)
    from_csv(csv_file_path).reduce({}) do |hash, row|
      if row[:hoa] == 'home'
        hash[row.first.last + 'h'] = collection_type.new(row)
      else
        hash[row.first.last + 'a'] = collection_type.new(row)
      end
      hash
    end
  end
end
