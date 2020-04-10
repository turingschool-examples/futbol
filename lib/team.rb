class Team
  # @@all_teams= []
  #
  # def self.all_teams
  #   @@all_teams
  # end

  # def self.from_csv(file_path)
  #     csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
  #
  #     @@all_teams = csv.map do |row|
  #
  #         # require"pry";binding.pry
  #         team = Team.new(row)
  #
  #     end
  #   end
  #
  # CSV.read(./data/teams.csv)
  attr_reader :team_id, :franchiseid, :teamname, :abbreviation, :stadium, :link
  def initialize(info)
    @team_id = info[:team_id].to_i
    @franchiseid = info[:franchiseid].to_i
    @teamname = info[:teamname]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end




end
