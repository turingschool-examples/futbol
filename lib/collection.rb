require 'csv'

class Collection
  attr_reader :collection

  def initialize(csv_file_path, collection_type)
    @collection = create_collection(csv_file_path, collection_type)
  end

  def from_csv(csv_file_path)
    CSV.foreach(csv_file_path, headers: true, header_converters: :symbol)
  end

  def create_collection(csv_file_path, collection_type)
    from_csv(csv_file_path).reduce({}) do |hash, row|
      hash[row.first.last] = collection_type.new(row)
      hash
    end
  end
end
