require './lib/tables/game_team_tables.rb'
require './lib/instances/game'
module CsvToHash
  def from_csv(csv_file)
    data = CSV.parse(File.read(csv_file), headers: true, converters: :numeric, header_converters: :symbol)
    array_of_hash = data.map{|row| row.to_h}
    # @object = array_of_hash.map {|row| Game.new(row)}
    require 'pry'; binding.pry
  end

end
