require_relative './helper_class'
require 'CSV'
require './lib/team_list'

class TeamList
    attr_reader :array

    def initialize
        @array = []
        array_fill
    end

    def array_fill
        CSV.foreach('./data/teams.csv', headers: true, header_converters: :symbol) do |row|
            team_id = row[:team_id].to_i
            franchise_id = row[:franchiseid].to_i
            team_name = row[:teamname].to_s
            abbreviation = row[:abbreviation].to_s
            stadium = row[:stadium].to_s
            link = row[:link].to_s
        
            new_team = Team.new(team_id,franchise_id,team_name,abbreviation,stadium,link)
        
            @array.append(new_team)
        end
    end
end