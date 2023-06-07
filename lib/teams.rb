class Team
  attr_reader :team_id,
              :franchise_id,
              :team_name,
              :abbreviation,
              :stadium,
              :link


  def initialize(data)
    @team_id = data[:team_id]
    @franchise_id = data[:franchiseid]
    @team_name = data[:teamname]
    @abbreviation = data[:abbreviation]
    @stadium = data[:stadium]
    @link = data[:link]
  end
end

# class TeamsParser
#   def self.parse(file_path)
#     CSV.read(file_path, headers: true).map do |row|
#       {
#         team_id: row['team_id'],
#         franchise_id: row['franchiseId'],
#         team_name: row['teamName'],
#         abbreviation: row['abbreviation'],
#         stadium: row['Stadium'],
#         link: row['link']
#       }
#     end
#   end