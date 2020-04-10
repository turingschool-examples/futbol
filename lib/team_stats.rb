require 'csv'

class TeamStats
  attr_reader :team_stats

  def initialize(file_path)
    @team_stats = create_team_stats(file_path)
  end

  def create_team_stats(file_path)
    team_stats_csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    team_stats_csv.map { |row| GameStats.new(row)}
  end

  def all_games_for(team_id)
    games_played = @team_stats.find_all do |team_stat|
      team_stat.team_id == team_id
    end
    games_played
  end
end
