require 'csv'
module Loadable

  def load_csv(filepath, class_type)
    info = CSV.read(filepath, headers: true, header_converters: :symbol)
    info.map do |row|
      accumulator << class_type.new(row)
    end
  end

end
