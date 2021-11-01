require 'csv'

module Parsable
  def make_objects(file_path, object)
    CSV.foreach(file_path, headers: true).map do |row|
      object.new(row)
    end
  end
end
