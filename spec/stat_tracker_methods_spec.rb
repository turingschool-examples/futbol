require 'rspec'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before :each do
    @games = [
      { game_id: '2012030221', season: '20122013', type: 'Postseason', date_time: '5/16/13', away_team_id: '3', home_team_id: '6', away_goals: '2', home_goals: '3', venue: 'Toyota Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030222', season: '20122013', type: 'Postseason', date_time: '5/19/13', away_team_id: '3', home_team_id: '6', away_goals: '2', home_goals: '3', venue: 'Toyota Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030223', season: '20122013', type: 'Postseason', date_time: '5/21/13', away_team_id: '6', home_team_id: '3', away_goals: '2', home_goals: '1', venue: 'BBVA Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030224', season: '20122013', type: 'Postseason', date_time: '5/23/13', away_team_id: '6', home_team_id: '3', away_goals: '3', home_goals: '2', venue: 'BBVA Stadium', venue_link: '/api/v1/venues/null' },
      { game_id: '2012030225', season: '20122013', type: 'Postseason', date_time: '5/25/13', away_team_id: '3', home_team_id: '6', away_goals: '1', home_goals: '3', venue: 'Toyota Stadium', venue_link: '/api/v1/venues/null' }
    ]

    @game_teams = [
      { game_id: '2012030221', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'OT', head_coach: 'John Tortorella', goals: '2', shots: '8', tackles: '44', pim: '8', powerPlayOpportunities: '3', powerPlayGoals: '0', faceOffWinPercentage: '44.8', giveaways: '17', takeaways: '7' },
      { game_id: '2012030221', team_id: '6', HoA: 'home', result: 'WIN', settled_in: 'OT', head_coach: 'Claude Julien', goals: '3', shots: '12', tackles: '51', pim: '6', powerPlayOpportunities: '4', powerPlayGoals: '1', faceOffWinPercentage: '55.2', giveaways: '4', takeaways: '5' },
      { game_id: '2012030222', team_id: '3', HoA: 'away', result: 'LOSS', settled_in: 'REG', head_coach: 'John Tortorella', goals: '2', shots: '9', tackles: '33', pim: '11', powerPlayOpportunities: '5', powerPlayGoals: '0', faceOffWinPercentage: '51.7', giveaways: '1', takeaways: '4' },
      { game_id: '2012030222', team_id: '6', HoA: 'home', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: '3', shots: '8', tackles: '36', pim: '19', powerPlayOpportunities: '1', powerPlayGoals: '0', faceOffWinPercentage: '48.3', giveaways: '16', takeaways: '6' },
      { game_id: '2012030223', team_id: '6', HoA: 'away', result: 'WIN', settled_in: 'REG', head_coach: 'Claude Julien', goals: '2', shots: '8', tackles: '28', pim: '6', powerPlayOpportunities: '0', powerPlayGoals: '0', faceOffWinPercentage: '61.8', giveaways: '10', takeaways: '7' }
    ]

    @teams = [
      { team_id: '1', franchiseId: '23', teamName: 'Atlanta United', abbreviation: 'ATL', Stadium: 'Mercedes-Benz Stadium', link: '/api/v1/teams/1' },
      { team_id: '2', franchiseId: '22', teamName: 'Seattle Sounders FC', abbreviation: 'SEA', Stadium: 'CenturyLink Field', link: '/api/v1/teams/2' },
      { team_id: '3', franchiseId: '21', teamName: 'Portland Timbers', abbreviation: 'POR', Stadium: 'Providence Park', link: '/api/v1/teams/3' },
      { team_id: '4', franchiseId: '20', teamName: 'New York Red Bulls', abbreviation: 'NY', Stadium: 'Red Bull Arena', link: '/api/v1/teams/4' },
      { team_id: '6', franchiseId: '19', teamName: 'LA Galaxy', abbreviation: 'LA', Stadium: 'StubHub Center', link: '/api/v1/teams/6' }
    ]

    @stat_tracker = StatTracker.new(@games, @game_teams, @teams)
  end
# Game Statistics

# highest_total_score
# Look for the highest sum of away_goals and home_goals across all games.

# lowest_total_score
# Look for the lowest sum of away_goals and home_goals across all games.

# percentage_home_wins
# Calculate the percentage of games won by the home team.
# Look for the number of games where the home team won (result is 'WIN') and divide it by the total number of games.

# percentage_visitor_wins
# Calculate the percentage of games won by the away team.
# Look for the number of games where the away team won (result is 'WIN') and divide it by the total number of games.

# percentage_ties
# Calculate the percentage of games that resulted in a tie.
# Look for the number of games where the result is a tie (away_goals = home_goals) and divide it by the total number of games.

# count_of_games_by_season
# Count the number of games for each season.
# Group the games by season and count the number of games in each group.

# average_goals_per_game
# Calculate the average number of goals scored per game.
# Sum up all the goals (away_goals + home_goals) and divide by the total number of games.

# average_goals_by_season
# Calculate the average number of goals scored per game for each season.
# Group the games by season, sum up the goals for each season, and divide by the number of games in that season.


# Team Statistics

# count_of_teams
# Count the total number of unique teams.
# Count the distinct team ids in the teams data.

# best_offense
# Find the team with the highest average number of goals scored per game.
# Calculate the average goals per game for each team and find the team with the highest average.

# worst_offense
# Find the team with the lowest average number of goals scored per game.
# Calculate the average goals per game for each team and find the team with the lowest average.

# highest_scoring_visitor
# Find the team with the highest average score per game when they are away.
# Filter the games where the team is away, calculate their average score per game, and find the team with the highest average.

# highest_scoring_home_team
# Find the team with the highest average score per game when they are home.
# Filter the games where the team is home, calculate their average score per game, and find the team with the highest average.

# lowest_scoring_visitor
# Find the team with the lowest average score per game when they are a visitor.
# Filter the games where the team is away, calculate their average score per game, and find the team with the lowest average.

# lowest_scoring_home_team
# Find the team with the lowest average score per game when they are at home.
# Filter the games where the team is home, calculate their average score per game, and find the team with the lowest average.


# Season Statistics

# winningest_coach
# Find the coach with the best win percentage for the season.
# Group the games by season and head coach, calculate the win percentage for each coach, and find the one with the highest percentage.

# worst_coach
# Find the coach with the worst win percentage for the season.
# Group the games by season and head coach, calculate the win percentage for each coach, and find the one with the lowest percentage.

# most_accurate_team
# Find the team with the best ratio of shots to goals for the season.
# Group the games by season and team, calculate the ratio of shots to goals for each team, and find the team with the highest ratio.

# least_accurate_team
# Find the team with the worst ratio of shots to goals for the season.
# Group the games by season and team, calculate the ratio of shots to goals for each team, and find the team with the lowest ratio.

# most_tackles
# Find the team with the most tackles in the season.
# Group the games by season and team, sum up the tackles for each team, and find the team with the highest total tackles.

# fewest_tackles
# Find the team with the fewest tackles in the season.
# Group the games by season and team, sum up the tackles for each team, and find the team with the lowest total tackles.



end
