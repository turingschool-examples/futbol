require 'csv'

module Loadable

  def load_csv(file_path, type)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    csv.map do |row|
      all << type.new(row)
    end
  end

end
