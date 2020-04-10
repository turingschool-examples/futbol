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
end
