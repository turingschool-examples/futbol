# Futbol

This project was created by a team of back-end students at Turing. The team consisted of Isaac Alter, Brad Dunlap, Antonio King Hunt, and Boston Lowrey.


## Function

This program allows the user to run data from a fictional soccer league to analyze team performance for specific seasons and across seasons. 

Using the runner file, the user can calculate any of the following statistics by running stat_tracker.name_of_method. For example, running stat_tracker.highest_scoring_visitor would return to you "FC Dallas", showing they had the highest average score per game across all seasons when they are away. 

#### The methods are:

### Game Statistics

##### highest_total_score
##### lowest_total score
##### percentage_home_wins
##### percentage_visitor_wins
##### percentage_ties
##### count_of_games_by_season
##### average_goals_per_game
##### average_goals_by_season

#### League Statistics

##### count_of_teams
##### best_offense
##### worst_offense
##### highest_scoring_visitor
##### lowest_scoring_visitor
##### highest_scoring_home_team
##### lowest_scoring_home_team

#### Season Statistics

##### winning_coach
##### worst_coach
##### most_accurate_team
##### least_accurate_team
##### most_tackles
##### fewest_tackles

#### Team Statistics

##### team_info
##### best_season
##### worst_season
##### average_win_percentage
##### most_goals_scored
##### fewest_goals_scored
##### favorite_opponent
##### rival

## Organization of Code
This code was separated into classes of Game, Team, and GameTeam in order to initialize each of those classes from the StatTracker class with the appropriate attributes. We also utilized modules to store shared code to use abstraction and encapsulation to keep the stat_tracker file as clean and simple as possible for the user and maintain the integrity of the code while keeping the complex methods hidden away.

## Refactor
Originally all the methods were created in one StatTracker class and was very exposed to the user and had 600+ lines of code. We first went through the code and determined where helper methods could use to keep the code DRY. Then we created our additional classes and modules to store the methods in order to keep them out of the StatTracker class, but make sure they were still accessible. 

## Version Control
Our team wanted to ensure the integrity of our version control, so we created new branches with a conventional naming system for each new method we implemented. We were in constant communication whenever one of us made a pull request and no one merged their own requests. We often utilized a paired driver/navigator system and had daily meetings to review and discuss our individual code. 

## Discussion Questions
### What was the most challenging aspect of this project?
The most challenging part of this project was design choice. We had a lot of ideas of how to organize the code and a lot of advice from our peers and instructors, but figuring out the best structure for the code for our group was challenging. The design definitely evolved along the way as we navigated through debugging and refactoring.

### What was the most exciting aspect of this project? 
Once all of our methods were written, we got to step back and see that we are now able to use large volumes of data and pull out very specific statistics with code that we wrote ourselves. The first time the spec harness fully passed was a celebration.

### Describe the best choice enumerables you used in your project. 
The two that stuck out to us was using CSV.foreach in order to access the CSV information with headers converted into symbols (StatTracker class in initialize), and find_all. We used find_all a LOT throughout this project in order to look through our data and pull out only the specific instances that we needed for that particular method. 

### Tell us about a module or superclass which helped you re-use code across repository classes. 
We utilized modules to hold the majority of our methods that are shared between our StatTracker Class and our Team, Game, and GameTeam Classes. This maintains the integrity of the code and hides the methods from the user and also allows that code to be shared across multiple classes. We also made a module called Analytics that holds calculations for finding averages that are then used throughout our methods. 

### Tell us about 1) a unit test and 2) an integration test that you are particularly proud of.


### Q&A
#### Please address the following questions from our team:
How would you have used a superclass for this project (as opposed to modules like we did)? (BD)

