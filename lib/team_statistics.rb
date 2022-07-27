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
    end
    def season_by_id(team_id)
        (@statistics.games.find_all {|row| row[:home_team_id] == team_id || row[:away_team_id] == team_id}).sort_by {|obj| obj[:season]}
    end
    def win_percentage(team_id, value)
        games = @statistics.games
        season_by_id = season_by_id(team_id)
        unique_total_seasons = season_by_id.uniq {|season| season[:season]}
        

        require 'pry'; binding.pry
    end
end