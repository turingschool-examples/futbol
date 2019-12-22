require_relative 'season'
require 'csv'

class SeasonCollection < Collection
  def initialize(csv_file_path)
    super(csv_file_path, Season)
  end

  def create_collection(csv_file_path, collection_type)
    from_csv(csv_file_path).reduce(Hash.new([])) do |hash, row|
      hash[row[:season]] += [collection_type.new(row)]
      hash
    end
  end
end
