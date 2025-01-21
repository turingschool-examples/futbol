require './lib/stat_tracker'

stats = StatTracker.from_csv({
    games: './data/games.csv',
    teams: './data/teams.csv',
    game_teams: './data/game_teams.csv'
})

p "Highest total score:"
p stats.highest_total_score
puts ''
p "Percentage home wins:"
p stats.percentage_home_wins
puts ''
p "Percentage visitor wins:"
p stats.percentage_visitor_wins
puts ''
p "Percentage ties:"
p stats.percentage_ties
puts ''
p "Winningest Coach:"
p stats.winningest_coach("20132014")