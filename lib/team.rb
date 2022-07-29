class Team

  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link

  attr_accessor :games_participated_in

  def initialize(teams_csv_row)
    @team_id = teams_csv_row[:team_id]
    @franchise_id = teams_csv_row[:franchiseid]
    @team_name = teams_csv_row[:teamname]
    @abbreviation = teams_csv_row[:abbreviation]
    @stadium = teams_csv_row[:stadium]
    @link = teams_csv_row[:link]
    @games_participated_in = []
  end

  def total_overall_goals
    @games_participated_in.sum do |game|
      if game.teams_game_stats[:home_team][:team_id] == @team_id
        game.teams_game_stats[:home_team][:goals]
      else
        game.teams_game_stats[:away_team][:goals]
      end
    end
  end

  def total_goals_per_side(key_of_side)
    @games_participated_in.sum do |game|
      if game.teams_game_stats[key_of_side][:team_id] == @team_id
        game.teams_game_stats[key_of_side][:goals]
      else
        0
      end
    end
  end

  def total_away_goals
    @games_participated_in.sum do |game|
      if game.teams_game_stats[:away_team][:team_id] == @team_id
        game.teams_game_stats[:away_team][:goals]
      else
        0
      end
    end
  end


  def self.generate_teams(team_csv)
    teams_hash = {}
    team_csv.each do |team|
      teams_hash[team[:team_id]] = Team.new(team)
    end
    teams_hash
  end

end