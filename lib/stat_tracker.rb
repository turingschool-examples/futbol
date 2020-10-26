require 'CSV'
class StatTracker
    attr_reader :data
    def initialize(data)
        @data = data
    end

    def self.from_csv(locations)
        data = {}
        game_id = []
        CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
            game_id << row[:game_id].to_i
        end
        data[:game_id] = game_id
        # locations.each_pair do |key, value|
        #     # value.parse
        #     table[key] = CSV.parse(File.read(value), headers: true, header_converters: :symbol)
        # end 
        # table
        stat_tracker = StatTracker.new(data)
        require 'pry'; binding.pry
    end

    # CSV.foreach('./data/games.csv', headers: true, header_converters: :symbol) do |row|
    #     game_id << row[:game_id].to_i 
    #     season = row[:season].to_i
    #     type = row[:type]   
    #     # date_time = 
    #     away_team_id = row[:away_team_id].to_i
    #     home_team_id = row[:home_team_id].to_i
    #     away_goals = row[:away_goals].to_i
    #     home_goals = row[:home_goals].to_i
    #     # venue
    #     # venue_link
    #     # require 'pry'; binding.pry
    # end  

    # def total_goals
        
    #         require 'pry'; binding.pry
       
    # end
end