require './lib/stat_tracker'
require 'erb'

game_path = './data/games.csv'
team_path = './data/teams.csv'
game_teams_path = './data/game_teams.csv'
locations = {
  games: game_path,
  teams: team_path,
  game_teams: game_teams_path
}
stat_tracker = StatTracker.from_csv(locations)

home_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1>Welcome to Futbol Stat Tracker!</h1>

      <a href = "./site/team_stats.html" > Team Statistics </a></br>
      <a href = "./site/game_stats.html" > Game Statistics </a></br>
      <a href = "./site/league_stats.html" > League Statistics </a></br>
      <a href = "./site/season_stats.html" > Season Statistics </a>

    </body>
  </html>
}

team_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1>Teams</h1>

        <% stat_tracker.teams_manager.teams.each do |team| %>
          <ul>
            <li><h3><%= team.team_name %></h3></li>
            <ul>
              <li><b>Team ID:</b> <%= team.team_id %></li>
              <li><b>Franchise ID:</b> <%= team.franchise_id %></li>
              <li><b>Abbreviation:</b> <%= team.abbreviation %></li>
              <li><b>Link:</b> <%= team.link %></li>
              <li><b>Best Season:</b> <%= stat_tracker.best_season(team.team_id) %></li>
              <li><b>Worst Season:</b> <%= stat_tracker.worst_season(team.team_id) %></li>
              <li><b>Average Win Percent of All games:</b> <%= stat_tracker.average_win_percentage(team.team_id) %></li>
              <li><b>Most Goals Scored in a Game:</b> <%= stat_tracker.most_goals_scored(team.team_id) %></li>
              <li><b>Fewest Goals Scores in a Game:</b> <%= stat_tracker.fewest_goals_scored(team.team_id) %></li>
              <li><b>Favorite Opponent:</b> <%= stat_tracker.favorite_opponent(team.team_id) %></li>
              <li><b>Rival:</b> <%= stat_tracker.rival(team.team_id) %></li>
            </ul>
          </ul>
        <% end %>
    </body>
  </html>
}

game_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1>Game Statistics</h1>
        <ul>
          <li><b>Highest Total Score in a Game:</b> <%= stat_tracker.highest_total_score %></li>
          <li><b>Lowest Total Score in a Game:</b> <%= stat_tracker.lowest_total_score %></li>
          <li><b>Percentage of Games Won by a Home Team:</b> <%= stat_tracker.percentage_home_wins %></li>
          <li><b>Percentage of Games Won by a Visiting Team:</b> <%= stat_tracker.percentage_visitor_wins %></li>
          <li><b>Percentage of Ties:</b> <%= stat_tracker.percentage_ties %></li>
          <li><b>Number of Games per Season:</b> <%= stat_tracker.count_of_games_by_season %></li>
          <li><b>Average Goals per Game:</b> <%= stat_tracker.average_goals_per_game %></li>
          <li><b>Average Goals per Game by Season:</b> <%= stat_tracker.average_goals_by_season %></li>
        </ul>
    </body>
  </html>
}

league_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1>League Statistics</h1>
        <ul>
          <li><b>Count of Teams:</b> <%= stat_tracker.count_of_teams %></li>
          <li><b>Best Offense:</b> <%= stat_tracker.best_offense %></li>
          <li><b>Worst Offense:</b> <%= stat_tracker.worst_offense %></li>
          <li><b>Highest Scoring Visitor:</b> <%= stat_tracker.highest_scoring_visitor %></li>
          <li><b>Highest Scoring Home Team:</b> <%= stat_tracker.highest_scoring_home_team %></li>
          <li><b>Lowest Scoring Visitor:</b> <%= stat_tracker.lowest_scoring_visitor %></li>
          <li><b>Lowest Scoring Home Team:</b> <%= stat_tracker.lowest_scoring_home_team %></li>
        </ul>
    </body>
  </html>
}

season_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1>Season Statistics</h1>
      <% [].each do |team| %>
        <ul>
          <li><h3><%= team.team_name %></h3></li>
      <ul>
        <li><b>Winningest Coach:</b> <%= stat_tracker.winningest_coach() %></li>
        <li><b>Worst Coach:</b> <%= stat_tracker.worst_coach() %></li>
        <li><b>Most Accurate Team:</b> <%= stat_tracker.most_accurate_team() %></li>
        <li><b>Least Accurate Team:</b> <%= stat_tracker.least_accurate_team() %></li>
        <li><b>Most Tackles in a Season:</b> <%= stat_tracker.most_tackles() %></li>
        <li><b>Least Tackles in a Season:</b> <%= stat_tracker.fewest_tackles() %></li>
      </ul>
      <% end %>
      
    </body>
  </html>
}




home = ERB.new(home_template)
home.run(binding)
File.write("./site/index.html", home.result(binding))

team_stats = ERB.new(team_stats_template)
team_stats.run(binding)
File.write("site/site/team_stats.html", team_stats.result(binding))

game_stats = ERB.new(game_stats_template)
game_stats.run(binding)
File.write("site/site/game_stats.html", game_stats.result(binding))

league_stats = ERB.new(league_stats_template)
league_stats.run(binding)
File.write("site/site/league_stats.html", league_stats.result(binding))

season_stats = ERB.new(season_stats_template)
season_stats.run(binding)
File.write("site/site/season_stats.html", season_stats.result(binding))
