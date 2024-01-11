require 'csv'

class StatTracker
    def self.from_csv(locations)
        #go through each file in the 
        locations.each do |file_name, file_path|
            CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
                if file_name == :games
                    #code
                elsif file_name == :teams
                    #code
                elsif file_name == :game_teams
                    #code
                else
                    puts "I don't have access to #{file_name}, sorry."
                end
            end
        end
    end
end