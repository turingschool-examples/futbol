require './lib/stat_tracker'
require './lib/team'


class TeamsManager
  attr_reader :data_path, :teams

  def initialize(data_path, stat_tracker)
    @data_path = data_path
    @stat_tracker = stat_tracker
    @teams = generate_list(@data_path)
  end

  def generate_list(data_path)
    list_of_data = []
    CSV.foreach(data_path, headers: true, header_converters: :symbol) do |row|
      list_of_data << Team.new(row)
    end
    list_of_data
  end


end
