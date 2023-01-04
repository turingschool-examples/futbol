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

    def initialize(info)
        # require 'pry'; binding.pry
        @game_id = info[:game_id]
        @season = info[:season]
        @type = info[:type]
        @date_time = info[:date_time]
        @away_team_id = info[:away_team_id]
        @home_team_id = info[:home_team_id]
        @away_goals = info[:away_goals].to_i
        @home_goals = info[:home_goals].to_i
        @venue = info[:venue]
        @venue_link = info[:venue_link]
    end
end

# correspond with the csv files 


# game.csv: need method that sorts info by away & home teamID
# group_by game ID number - put info into a hash
# add scores from away_goals & home_goals
# use max_by and min_by enumerables to find the winning and losing teams
# highest_total_score is the highest sum of winning & losing teams scores
