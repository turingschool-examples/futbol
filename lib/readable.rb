module Readable
  def generate_list(data_path, object)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << object.new(row)
    end
    list_of_data
  end
end
