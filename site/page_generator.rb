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

      <b><h1 class='header'>Welcome to Futbol Stat Tracker!</h1></b>

      <b><a href = "./site/team_stats.html" target ="_blank"> Team Statistics</a>   |</b>
      <b><a href = "./site/game_stats.html" target ="_blank"> Game Statistics</a>   |</b>
      <b><a href = "./site/league_stats.html" target ="_blank"> League Statistics</a>   |</b>
      <b><a href = "./site/season_stats.html" target ="_blank"> Season Statistics</a></b>

    </body>
  </html>

  <style>
    body {
      background-color: #379683;
      text-align: center;
      font-family: "Verdana";
      color: EDF5E1;
      font-size: 28px;
    }
    a:link {
      color: EDF5E1;
      font-size: 23px;
    }
    a:visited {
      color: EDF5E1;
      font-size: 23px;
    }
    .header {
      padding: 60px;
      text-align: center;
      background: #05386B;
      color: EDF5E1;
      font-size: 30px;
    }
  </style>
}

team_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1>Team Statistics</h1>

        <% stat_tracker.teams_manager.teams.each do |team| %>
          <ul>
            <h3><%= team.team_name %></h3>
            <ul>
              <li><b>Team ID:</b> <%= team.team_id %></li>
              <li><b>Franchise ID:</b> <%= team.franchise_id %></li>
              <li><b>Abbreviation:</b> <%= team.abbreviation %></li>
              <li><b>Best Season:</b> <%= stat_tracker.games_manager.format_seasons(stat_tracker.best_season(team.team_id)) %></li>
              <li><b>Worst Season:</b> <%= stat_tracker.games_manager.format_seasons(stat_tracker.worst_season(team.team_id)) %></li>
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
  <style>
    h1 {
      padding: 55px;
      text-align: left;
      background: #05386B;
      color: EDF5E1;
      font-size: 34px;
    }
    h3 {
      background-color: #379683;
      text-align: left;
      font-family: "Verdana";
      color: EDF5E1;
      font-size: 28px;
    }
    body {
      background-color: #379683;
      text-align: left;
      font-family: "Verdana";
      color: #05386B;
      font-size: 18px;
    }
    a:link {
      color: EDF5E1;
      font-size: 23px;
    }
    a:visited {
      color: EDF5E1;
      font-size: 23px;
    }
  </style>
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
          <li><b>Average Goals per Game:</b> <%= stat_tracker.average_goals_per_game %></li>
          <li><b>Number of Games per Season:</b> <% stat_tracker.count_of_games_by_season.each do |season, count| %>
            <ul>
              <li><b><%= stat_tracker.games_manager.format_seasons(season) %>:</b> <%= count %></li>
            </ul>
          <% end %></li>
          <li><b>Average Goals per Game by Season:</b> <% stat_tracker.average_goals_by_season.each do |season, avg_goals| %>
            <ul>
              <li><b><%= stat_tracker.games_manager.format_seasons(season) %>:</b> <%= avg_goals %></li>
            </ul>
          <% end %></li>
        </ul>
    </body>
  </html>
  <style>
    h1 {
      padding: 35px;
      text-align: left;
      background: #05386B;
      color: EDF5E1;
      font-size: 23px;
    }
    body {
      background-color: #379683;
      text-align: left;
      font-family: "Verdana";
      color: #05386B;
      font-size: 14px;
    }
    a:link {
      color: EDF5E1;
      font-size: 23px;
    }
    a:visited {
      color: EDF5E1;
      font-size: 23px;
    }
  </style>
}

league_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

      <h1 class='header'>League Statistics</h1>
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
  <style>
  h1 {
    padding: 35px;
    text-align: left;
    background: #05386B;
    color: EDF5E1;
    font-size: 23px;
  }
  body {
    background-color: #379683;
    text-align: left;
    font-family: "Verdana";
    color: #05386B;
    font-size: 14px;
  }
    h3 {
      background-color: #379683;
      text-align: left;
      font-family: "Verdana";
      color: EDF5E1;
      font-size: 23px;
  }
    a:link {
      color: EDF5E1;
      font-size: 23px;
  }
    a:visited {
      color: EDF5E1;
      font-size: 23px;
  }

  </style>
}

season_stats_template = %{
  <html>
    <head><title><%= "Stat Tracker" %></title></head>
    <body>

    <h1 class='header'>Season Statistics</h1>
      <% stat_tracker.games_manager.seasons.each do |season| %>
        <ul>
          <h3><%= stat_tracker.games_manager.format_seasons(season) %></h3>
          <ul>
            <li><b>Winningest Coach:</b> <%= stat_tracker.winningest_coach(season) %></li>
            <li><b>Worst Coach:</b> <%= stat_tracker.worst_coach(season) %></li>
            <li><b>Most Accurate Team:</b> <%= stat_tracker.most_accurate_team(season) %></li>
            <li><b>Least Accurate Team:</b> <%= stat_tracker.least_accurate_team(season) %></li>
            <li><b>Most Tackles in a Season:</b> <%= stat_tracker.most_tackles(season) %></li>
            <li><b>Least Tackles in a Season:</b> <%= stat_tracker.fewest_tackles(season) %></li>
          </ul>
        </ul>
      <% end %>
    </body>
  </html>
  <style>
  h1 {
    padding: 35px;
    text-align: left;
    background: #05386B;
    color: EDF5E1;
    font-size: 23px;
  }
  body {
    background-color: #379683;
    text-align: left;
    font-family: "Verdana";
    color: #05386B;
    font-size: 14px;
  }
    h3 {
      background-color: #379683;
      text-align: left;
      font-family: "Verdana";
      color: EDF5E1;
      font-size: 18px;
  }
    a:link {
      color: EDF5E1;
      font-size: 23px;
  }
    a:visited {
      color: EDF5E1;
      font-size: 23px;
  }
  </style>
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
