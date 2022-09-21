require 'erb'
require './lib/stat_tracker'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'

locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}

stat_tracker = StatTracker.from_csv(locations)

template = %(
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
  </head>
  <body>
    <div class="container-lg">
<div class="container-lg">
  <div class="row">
    <div class="col bg-color bg-primary text-light p-3 d-flex justify-content-center">
      <h3>Team Ryan, Sean, Yuji, Michael</h3>
    </div>
  </div>
  <div class="row d-flex flex-column m-3">
    <h1>Game Statistics</h1>
    <div class="col border border-1">
      <h3>highest_total_score</h3>
      <%= stat_tracker.highest_total_score %>
    </div>
    <div class="col border border-1">
      <h3>lowest_total_score</h3>
      <%= stat_tracker.lowest_total_score %>
    </div>
    <div class="col border border-1">
      <h3>percentage_home_wins</h3>
      <%= stat_tracker.percentage_home_wins %>
    </div>
    <div class="col border border-1">
      <h3>percentage_visitor_wins</h3>
      <%= stat_tracker.percentage_visitor_wins %>
    </div>
    <div class="col border border-1">
      <h3>percentage_ties</h3>
      <%= stat_tracker.percentage_ties %>
    </div>
    <div class="col border border-1">
      <h3>count_of_games_by_season</h3>
      <%= stat_tracker.count_of_games_by_season %>
    </div>
    <div class="col border border-1">
      <h3>average_goals_per_game</h3>
      <%= stat_tracker.average_goals_per_game %>
    </div>
    <div class="col border border-1">
      <h3>average_goals_by_season</h3>
      <%= stat_tracker.average_goals_by_season %>
    </div>
  </div>
  <div class="row d-flex flex-column m-3">
    <h1>League Statistics</h1>
    <div class="col border border-1">
      <h3>count_of_teams</h3>
      <%= stat_tracker.count_of_teams %>
    </div>
    <div class="col border border-1">
      <h3>best_offense</h3>
      <%= stat_tracker.best_offense %>
    </div>
    <div class="col border border-1">
      <h3>worst_offense</h3>
      <%= stat_tracker.worst_offense %>
    </div>
    <div class="col border border-1">
      <h3>highest_scoring_visitor</h3>
      <%= stat_tracker.highest_scoring_visitor %>
    </div>
    <div class="col border border-1">
      <h3>highest_scoring_home_team</h3>
      <%= stat_tracker.highest_scoring_home_team %>
    </div>
    <div class="col border border-1">
      <h3>lowest_scoring_visitor</h3>
      <%= stat_tracker.lowest_scoring_visitor %>
    </div>
    <div class="col border border-1">
      <h3>lowest_scoring_home_team</h3>
      <%= stat_tracker.lowest_scoring_home_team %>
    </div>
  </div>
  <div class="row d-flex flex-column m-3">
    <h1>Season Statistics</h1>
    <div class="col border border-1">
      <h3>winningest_coach</h3>
      <%= stat_tracker.winningest_coach("20122013") %>
    </div>
    <div class="col border border-1">
      <h3>worst_coach</h3>
      <%= stat_tracker.worst_coach("20122013") %>
    </div>
    <div class="col border border-1">
      <h3>most_accurate_team</h3>
      <%= stat_tracker.most_accurate_team("20122013") %>
    </div>
    <div class="col border border-1">
      <h3>least_accurate_team</h3>
      <%= stat_tracker.least_accurate_team("20122013") %>
    </div>
    <div class="col border border-1">
      <h3>most_tackles</h3>
      <%= stat_tracker.most_tackles("20122013") %>
    </div>
    <div class="col border border-1">
      <h3>fewest_tackles</h3>
      <%= stat_tracker.fewest_tackles("20122013") %>
    </div>
  </div>
  <div class="row d-flex flex-column m-3">
    <h1>Team Statistic</h1>
    <div class="col border border-1">
      <h3>team_info</h3>
      <%= stat_tracker.team_info('1') %>
    </div>
    <div class="col border border-1">
      <h3>best_season</h3>
      <%= stat_tracker.best_season('1') %>
    </div>
    <div class="col border border-1">
      <h3>worst_season</h3>
      <%= stat_tracker.worst_season('1') %>
    </div>
    <div class="col border border-1">
      <h3>average_win_percentage</h3>
      <%= stat_tracker.average_win_percentage('1') %>
    </div>
    <div class="col border border-1">
      <h3>most_goals_scored</h3>
      <%= stat_tracker.most_goals_scored('1') %>
    </div>
    <div class="col border border-1">
      <h3>fewest_goals_scored</h3>
      <%= stat_tracker.fewest_goals_scored('1') %>
    </div>
    <div class="col border border-1">
      <h3>favorite_opponent</h3>
      <%= stat_tracker.favorite_opponent('1') %>
    </div>
    <div class="col border border-1">
      <h3>fewest_goals_scored</h3>
      <%= stat_tracker.fewest_goals_scored('1') %>
    </div>
  </div>


</div>









    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
  </body>
</html>

)

html = ERB.new(template).result(binding)
puts html

File.write('site/index.html.erb', html)
