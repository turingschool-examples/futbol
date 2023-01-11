![soccer-players-in-action-on-professional-stadium](https://user-images.githubusercontent.com/115383288/211674429-dae140a0-b795-4c18-89fc-583448015dbe.jpg)

# Futbol - Statistic Tracker

## Description
This project focuses on building a program that can use CSV files containing data of a soccer league. This program allows us to analyze team performance for specific seasons or across all seasons. There are multiple different statistics that can be called upon, see [Statistics Names](#statistic-names)

## Running Program
The program can be ran from the terminal or command prompt by typing: `ruby runner.rb`.

The program will start and hit a pry, which you can then preface the statistic name with `stat_tracker`.

![Integration Test](https://user-images.githubusercontent.com/115383288/211680089-76e50357-7460-42d3-9db0-ea00199d84bd.png)


Some examples include:

`stat_tracker.winningest_coach`

`stat_tracker.best_season`

`stat_tracker.highest_scoring_visitor`

See [Statistics Names](#statistic-names) for all statistics that can be called.
## Colaborators
[Axel De La Guardia](https://github.com/axeldelaguardia)

[Chris Crane](https://github.com/GreenGogh47)

[Conner Van Loan](https://github.com/C-V-L)
	
## Technical Quality and Organization of Code
After all methods were created, we first decided we wanted to sit each CSV::Row of our data as an object with it's attributes including each header of the CSV::Row. We then iterated through all the rows and to create an instance of the object for each *game*, *game_team*, and *team*. This allowed us to easily access the data needed when refactoring our methods.

We then decided to create a class for each specific group of statistic. These statistics were grouped by *Game Statistics*, *League Statistics*, *Season Statistics*, and *Team Statistics*. We sat most of our methods for the specific group in their dedicated class while passing our *game*, *game_team*, and *team* into them as arguments.

Without practice of inheritance, implementing this into our code was a bit of a challenge but was done. With this being said, this is one of the design decisions that brings pride to the group. We chose to use both inheritance and modules in our project. 
1. We noticed that a lot of methods we're being frequently used across our code and realized that those can be pulled out and included in our classes as a module.
1. We also noticed that we would be creating the row objects in each of our classes and creating them as attributes in all of our statistic classes. This allowed us to pull those attributes and sit them in a parent class for our refactored *stat_tracker* class.

Hashes were used across all of our project. There were multiple times in the project were specific data needed to be asigned to another piece of specific data. For example, if we needed all games for a season, we can set all seasons as keys and the games associated to those seasons as values.

## Identifying areas of code to refactor
- When it came time to refactoring in iteration 3, several methods were extremely long and some were not using previous helper methods we had created. Part of the refactoring process was pulling smaller methods into our module to then use across multiple classes.
- Seeing code that can stand alone also helped identifying the creation of helper methods. There were many instances that we could pull specific code to create a helper method with just adding an argument to our new method.
- Refactoring feels like a never ending process and we are positive there are many other ways to continue cleaning up our code.

## Collaboration/Version Control
- For iteration 1, we mostly worked together to make sure we understood how we were starting the project. When iteration 2 came around, we decided to divide all the methods among each other and discussed the difficulty of the methods to assure no one person was getting more work than another. Although we divided the work among each other, we stuck around on a zoom call to make sure we had quick access to other group member opinions and assistance.
- One thing to note is that being on a zoom call together for most of the project allowed us to solve merge conflicts as a group thus making it quicker and much easier than if doing them individually.
- We began using Trello to track the progress of our project and later moved over to tracking on a Google Spreadsheet.

## Discussion of Test Coverage
### 100% Coverage Across All Classes

![Coverage](https://user-images.githubusercontent.com/115383288/211678959-f1b6a338-1abd-47af-a667-ab3244e1943b.png)

### Integration Testing

![Integration Test - Method](https://user-images.githubusercontent.com/115383288/211679367-c19e8da0-6108-456c-9ec5-4aab8a1c6466.png)
![Integration Test](https://user-images.githubusercontent.com/115383288/211679465-494953b2-d504-4dba-ad7d-7eed341b0e1b.png)

### Unit Testing

![Unit Test - Method](https://user-images.githubusercontent.com/115383288/211680388-85a36fe6-e653-4d14-be7d-547ad8924fc6.png)
![Unit Test](https://user-images.githubusercontent.com/115383288/211680625-631b3fe7-c7e0-4c30-93ac-361360af4ecf.png)

### Running spec_harness
![Unit Test](https://user-images.githubusercontent.com/115383288/211680784-74e7070f-8dc8-429a-93f5-c3273072e65e.png)



## Chris Cane
The `group_by` enumerable was extremely useful. We used it in the following methods in the modules.rb
- games_played_by_season (line 3)
- games_by_game_id (line 9)
- find_team_by_id (line 15)
- games_by_team_id (line 25)

By creating those modules that would parse up our data initially, it cleaned up a lot of our methods throughout our other classes. We did use other enumerables like `sum` and `map`, but we relied heavily on `each` since there was a fair amount of 'reaching through objects'.


The superclass `Stats` stores the return value of a class method of 3 other classes, Game, GameTeams, and Team. The return value is an array of instances of the 3 classes. It was then passed into our 3 instance variables `@games`, `@game_teams`, `@teams` which then hold those arrays.

The `stat_tracker` class is the subclass. It takes the 3 created instance variables (created from the CSV files), and uses them as arguments to create the last 4 classes where those associated methods live (`game_stats`, `league_stats`, `season_stats`, and `team_stats`).

Using both a module and inheritance cleaned up our code in very nice ways. Because the code was divided up cleanly, it was easier to spot code that was repeated. It also made our tests run noticeably faster.

## Wins & Challenges
1. There were a few challenges that came with a couple of the statistics, such as, Favorite Opponent/Rival and Winningest/Coach. Having to cross reference multiple CSV files to find the correct result and finding what our test should expect before coding our method were among those contenders but in the end, it felt like a win when it was accomplished.
1. During iteration 3, we found that memoization of some of helper methods optimized our program ten fold. It felt like a big achievement to see it working in under a second.

## Future Iterations
1. Adding a feature that allows this program to run without hitting a pry.
1. Continue the never ending refactor process.
1. Adding CSV files to change the data entered.

## Statistic Names

- highest_total_score
- lowest_total_score
- percentage_home_wins
- percentage_visitor_wins
- percentage_ties
- count_of_games_by_season
- average_goals_per_game
- average_goals_by_season
- count_of_teams
- best_offense
- worst_offense
- highest_scoring_visitor
- highest_scoring_home_team
- lowest_scoring_visitor
- lowest_scoring_home_team
- winningest_coach
- worst_coach
- most_accurate_team
- least_accurate_team
- most_tackles
- fewest_tackles
- team_info
- best_season
- worst_season
- most_goals_scored
- fewest_goals_scored
- favorite_opponent
- rival