# require_relative './helper_class'

class Game
    attr_reader :game_id,
                :season,
                :type,
                :date_time,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue,
                :venue_link

    def initialize(game_data)
       @game_id = game_data[:game_id]
       @season = game_data[:season]
       @type = game_data[:type]
       @date_time = game_data[:date_time]
       @away_team_id = game_data[:away_team_id]
       @home_team_id = game_data[:home_team_id]
       @away_goals = game_data[:away_goals].to_i
       @home_goals = game_data[:home_goals].to_i
       @venue = game_data[:venue]
       @venue_link = game_data[:venue_link]    
    end

end
# replace row lines w data set
class_info = {:game_id => row[:game_id],
:season => row[:season],
:type => row[:type],
:date_time => row[:date_time],
:away_team_id => row[:away_team_id],
:home_team_id => row[:home_team_id],
:away_goals => row[:away_goals],
:home_goals => row[:home_goals],
:venue => row[:venue],
:venue_link => row[:venue_link]}
games << Game.new(class_info)

# test whether it takes in the string and seee if it converts to int