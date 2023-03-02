module TestData
  game_path = './spec/fixtures/games_sample.csv'
  team_path = './data/teams.csv'
  game_teams_path = './spec/fixtures/game_teams_sample.csv'

  LOCATIONS ||= {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
  }.freeze

  DATA = {}
  LOCATIONS.each do |key, csv_file_path|
    DATA[key] = CSV.open(csv_file_path, headers: true, header_converters: :symbol)
    DATA[key] = DATA[key].to_a.map do |row|
      row.to_h
    end
  end
  DATA.freeze
end
