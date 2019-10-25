class Team
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link

  def initialize(team_info, all_team_games)
    @team_id = team_info[:team_id]
    @franchise_id = team_info[:franchiseid].to_i
    @team_name = team_info[:teamname]
    @abbreviation = team_info[:abbreviation]
    @all_team_games = all_team_games
  end

  def win_percentage
    win_count = @all_team_games.count do |game|
      game.result == "WIN"
    end
    (win_count / @all_team_games.length.to_f).round(2)
  end
end
