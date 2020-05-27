require "csv"

class GameTeamCollection
  def initialize(gt_csv)
    @gt_csv = gt_csv
  end

  def all
    rows = CSV.read(@gt_csv, headers: true, header_converters: :symbol)
    rows.reduce([]) do |game_teams, row|
      game_teams << GameTeam.new(row)
      game_teams
    end
  end

  def find_all_by(id)
    all.find_all do |game_team|
      game_team.team_id == id || game_team.game_id == id
    end
  end

end
