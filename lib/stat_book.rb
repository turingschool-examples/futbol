require 'csv'

class StatBook
  def initialize(source)
    file = CSV.read source, headers: true, header_converters: :symbol
    file.headers.each { |header| instance_variable_set("@#{header}", file[header]) }
  end
end