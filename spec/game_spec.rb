require'csv'
require'rspec'
require'./lib/games.rb'


RSpec.describe Game do
  it 'exists' do
  #game = CSV.open './data/games.csv'
   game = Game.new({game_id: 2012030221, season: 20122013, type: "Postseason", date_time: 5/16/13, away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"})
   expect(game).to be_an_instance_of(Game)
 end

  it' has readable info' do
   game = Game.new({game_id: 2012030221, season: 20122013, type: "Postseason", date_time: 5/16/13, away_team_id: 3, home_team_id: 6, away_goals: 2, home_goals: 3, venue: "Toyota Stadium", venue_link: "/api/v1/venues/null"})
   expect(game.game_id).to eq(2012030221)
   expect(game.season).to eq(20122013)
   expect(game.type).to eq("Postseason")
   expect(game.date_time).to eq(5/16/13)
   expect(game.away_team_id).to eq(3)
   expect(game.home_team_id).to eq(6)
   expect(game.away_goals).to eq(2)
   expect(game.home_goals).to eq(3)
   expect(game.venue).to eq("Toyota Stadium")
   expect(game.venue_link).to eq("/api/v1/venues/null")

  end
end



# Method	/Description	/Return Value
# highest_total_score	/Highest sum of the winning and losing teams’ scores/	Integer
# lowest_total_score	/Lowest sum of the winning and losing teams’ scores	/Integer
# percentage_home_wins/	Percentage of games that a home team has won (rounded to the nearest 100th)/	Float
# percentage_visitor_wins	/Percentage of games that a visitor has won (rounded to the nearest 100th)/	Float
# percentage_ties	Percentage /of games that has resulted in a tie (rounded to the nearest 100th)/	Float
# count_of_games_by_season/	A hash with season names (e.g. 20122013) as keys and counts of games as values/	Hash
# average_goals_per_game/	Average number of goals scored in a game across all seasons including both home and away goals /(rounded to the nearest 100th)	Float
# average_goals_by_season	/Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values /(rounded to the nearest 100th)
