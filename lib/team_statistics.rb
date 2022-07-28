class TeamStatistics
    def initialize(statistics)
        @statistics = statistics
    end
    def team_info(team_id)
        # returns hash with team_id, franchise_id, team_name, abbreviation, and link
        team_index = @statistics.teams[:team_id].index(team_id)
        team_info_return = (@statistics.teams[team_index].to_h).reject {|key, _value| key == :stadium}
    end
    def best_season(team_id)
        # returns season with the highest win percentage for a team as string
        win_percentage(team_id, :highest_win)
        require 'pry'; binding.pry
    end
    def worst_sesson(team_id)
        win_percentage(team_id, :lowest_win)
        require 'pry'; binding.pry
    end
    def season_by_id(team_id)
        games = @statistics.games
        season_by_id = (games.find_all {|row| row[:home_team_id] == team_id || row[:away_team_id] == team_id}).sort_by {|obj| obj[:season]}
    end
    def win_percentage(team_id, data_choice)
        game_by_season = season_by_id(team_id)
        total_season = (game_by_season.uniq {|season| season[:season]}).map {|season| season[:season]}
        total_count = Hash.new
        total_season.each {|season| total_count.store(season,[0.0, 0.0, 0.0])}
        # calculate total games in total_count[0], then wins in total_count[1], then loss in total_count[2]
        total_season.each do |season|
            game_by_season.each do |row|
                if row[:season] == season
                    total_count[season][0] += 1
                    if row[:home_team_id] == team_id
                        if row[:home_goals] > row[:away_goals]
                            total_count[season][1] += 1
                        end
                    elsif row[:away_team_id] == team_id
                        if row[:away_goals] > row[:home_goals]
                            total_count[season][1] += 1
                        end
                    end
                end
            end
        end
        # changes floats to percent
        total_count.each do |key,value|
            value[1] = ((value[1] / 100)*100).round(2)
            value[2] = value[0] - value[1]
            value[2] = ((value[2] / 100)*100).round(2)
        end

        highest_percent = 0
        lowest_percent = 100
        winning_season = nil
        losing_season = nil

        # returns the winning_season and losing_season by comparing floats in total_count
        total_count.each do |key,value|
            if highest_percent < value[1]
                highest_percent = value[1]
                winning_season = key
            elsif value[1] < lowest_percent
                lowest_percent = value[1]
                losing_season = key
            end
        end

        if data_choice == :highest_win
            return winning_season
        else 
            return losing_season
        end
    end
end
