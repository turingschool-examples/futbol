class Team
  @@all_teams= []

  def self.all_teams
    @@all_teams
  end

  def self.from_csv(file_path)
      csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)

      @@all_teams = csv.map do |row|
         # require"pry";binding.pry
          Team.new(row)
           # require"pry";binding.pry
      end
    end
  #
  # CSV.read(./data/teams.csv)
  attr_reader :team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link
  def initialize(info)
    @team_id = info[:team_id].to_i
    @franchise_id = info[:franchise_id].to_i
    @team_name = info[:team_name]
    @abbreviation = info[:abbreviation]
    @stadium = info[:stadium]
    @link = info[:link]
  end




end
