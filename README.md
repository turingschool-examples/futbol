![image](https://user-images.githubusercontent.com/78194232/140588612-210bcab2-9351-43e4-87d9-883a7fb20bef.png)

# Futbol
Is a program created to analyze fictional football (soccer for the yanks) league statistics. Our program utilizes data read from CSV, which can be then used for calculating statistics in four different categories of League, Season, Team and Game.
## Setup (for Unix based systems):
### 1. Clone this repository:
---
Theres is no need to fork the repository, cloning is just fine to your directory of choice. Start by opening up your terminal, and typing the following commands for either ssh or https to clone the directory. Once cloned, you'll have a new local copy in your directory.
```shell
// using ssh key
$ git clone git@github.com:tjroeder/futbol.git

// using https
$ git clone https://github.com/tjroeder/futbol.git
```
### 2. Change to the project directory:
---
In terminal, utilize the `cd` command to change to the futbol project directory. 
```shell
$ cd futbol/
```

### 3. Install required Gems utilizing Bundler:
---
In terminal, use Bundler to install any missing Gems. If Bundler is not installed first run the following command.
```shell
$ gem install bundler
```

If Bundler is already installed or after it has been installed, then run the following command.
```shell
$ bundle install
```
There should be be verbose text diplayed of the installation process that looks similar to below. (this is not an actual copy of what will be output).
```shell
$ bundle install
Fetching gem metadata from https://rubygems.org/........
Resolving dependencies...
Using bundler 2.1.4
Using byebug 11.1.3
Fetching coderay 1.1.2
Installing coderay 1.1.2
Using diff-lcs 1.4.4
Using method_source 1.0.0
Using pry 0.13.1
Fetching pry-byebug 3.9.0
Installing pry-byebug 3.9.0
Fetching rspec-support 3.10.1
Installing rspec-support 3.10.1
Fetching rspec-core 3.10.1
Installing rspec-core 3.10.1
Fetching rspec-expectations 3.10.1
Installing rspec-expectations 3.10.1
Fetching rspec-mocks 3.10.1
Installing rspec-mocks 3.10.1
Fetching rspec 3.10.0
Installing rspec 3.10.0
Bundle complete! 3 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

If there are any errors, verify that bundler or your ruby environment was correctly setup.

### 4. Run the StatTracker:
From the terminal, utilize the runner.rb file to use the Futbol StatTracker class.

```shell
$ ruby runner.rb
```
To try the StatTracker for yourself in the terminal, open up a `pry` or `irb` session to play with the available statistics. 

```shell
$ pry // irb
```
In pry/irb session require the StatTracker class file, define your CSV file locations and create a new instance to begin. 
```ruby 
$ require './stat_tracker.rb'
$ game_data = './data/games.csv'
$ team_data = './data/teams.csv'
$ game_team_data = './data/game_teams.csv'
$ new_stat_tracker = StatTracker.from_csv(game_data, team_data, game_team_data)
```


## StatTracker Methods:
### Game Statistics:
| **Method** | **Description** | **Return Value** |
|--------|-------------|--------------|
|`highest_total_score`|Highest sum of the winning and losing teams’ scores.|Integer|
|`lowest_total_score`|Lowest sum of the winning and losing teams’ scores.|Integer|
|`percentage_home_wins`|Percentage of games that a home team has won (rounded to the nearest 100th).|Float|
|`percentage_visitor_wins`|Percentage of games that a visitor has won (rounded to the nearest 100th).|Float|
|`percentage_ties`|Percentage of games that has resulted in a tie (rounded to the nearest 100th).|Float|
|`count_of_games_by_season`|A hash with season names (e.g. 20122013) as keys and counts of games as values.|Hash|
|`average_goals_per_game`|Average number of goals scored in a game across all seasons including both home and away goals (rounded to the nearest 100th).|Float|
|`average_goals_by_season`|Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values (rounded to the nearest 100th).|Hash|

### League Statistics:
| **Method** | **Description** | **Return Value** |
|--------|-------------|--------------|
|```count_of_teams```|Total number of teams in the data.|Integer|
|```best_offense```|Name of the team with the highest average number of goals scored per game across all seasons.|String|
|```worst_offense```|Name of the team with the lowest average number of goals scored per game across all seasons.|String|
|```highest_scoring_visitor```|Name of the team with the highest average score per game across all seasons when they are away.|String|
|```highest_scoring_home_team```|Name of the team with the highest average score per game across all seasons when they are home.|String|
|```lowest_scoring_visitor```|Name of the team with the lowest average score per game across all season when they are a visitor.|Hash|
|```lowest_scoring_home_team```|Name of the team with the lowest average score per game across all seasons when they are at home.|String|

### Season Statistics:

| **Method** | **Description** | **Return Value** |
|--------|-------------|--------------|
|`winningest_coach`|Name of the coach with the best win percentage for the season.|String|
|`worst_coach`|Name of the coach with the worst win percentage for the season.|String|
|`most_accurate_team`|Name of the team with the best ratio of shots to goals for the season.|String|
|`least_accurate_team`|Name of the team with the worst ratio of shots to goals for the season.|String|
|`most_tackles`|Name of the team with the most tackles in the season.|String|
|`fewest_tackles`|Name of the team with the fewest tackles in the season.|String|

### Team Statistics:

| **Method** | **Description** | **Return Value** |
|--------|-------------|--------------|
|`team_info`|A hash with key/value pairs for the following attributes: team_id, franchise_id, team_name, abbreviation, and link.|Hash|
|`best_season`|Season with the highest win percentage for a team.|String|
|`worst_season`|Season with the lowest win percentage for a team.|String|
|`average_win_percentage`|Average win percentage of all games for a team.|Float|
|`most_goals_scored`|Highest number of goals a particular team has scored in a single game.|Integer|
|`fewest_goals_scored`|Lowest number of goals a particular team has scored in a single game.|Integer|
|`favorite_opponent`|Name of the opponent that has the lowest win percentage against the given team.|String|
|`rival`|Name of the opponent that has the highest win percentage against the given team.|String|


# Contributors:

[Chris Hewitt](https://github.com/Henchworm)

[Tim Roeder](https://github.com/tjroeder)

[Jackson Valdez](https://github.com/jacksonvaldez)

[Josh Walsh](https://github.com/jaw772)

---
This project is based on the starter repository for the [Turing School](https://turing.io/) Futbol project.

###### Or is this actually hockey stats? I really don't really know...