require 'csv'

class TeamsParser
  def self.parse(file_path)
    CSV.read(file_path, headers: true).map do |row|
      {
        team_id: row['team_id'],
        franchise_id: row['franchiseId'],
        team_name: row['teamName'],
        abbreviation: row['abbreviation'],
        stadium: row['Stadium'],
        link: row['link']
      }
    end
  end
end
