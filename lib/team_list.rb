require 'CSV'
require_relative './team'


class TeamList
    attr_reader :teams

    def initialize(path, stat_tracker)
        @teams = create_teams(path)
        # require 'pry'; binding.pry
    end

    def create_teams(path)
        data = CSV.parse(File.read(path), headers: 
        true, header_converters: :symbol)
        data.map do |datum|
            # require 'pry'; binding.pry
            Team.new(datum,self)
        end
    end

end