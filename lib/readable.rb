module Readable


  def build(file_location, hash_name, class_name)
    CSV.foreach(File.read(file_location), headers: true, header_converters: :symbol) do |row|
      hash_name[row[:game_id]] = class_name.new(row)
    end
  end

end
