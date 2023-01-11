# Futbol
 
Starter repository for the [Turing School](https://turing.io/) Futbol project.
 
 
As a group, discuss and write your answers to the following questions. Include your responses as a section in your project README.
 
# What was the most challenging aspect of this project?
 
We found some of the most challenging aspects of the project in the beginning involved git workflow and merge conflicts between 4 people and multiple branches. We were also faced with the obstacles of figuring out how to work with the csv files and nested iterations. We had set up our project in one way by creating class files, but needed to backtrack and figure out how to access information using hashes instead. Overall, the experience has resulted in a deeper understanding of hashes and workflow.
 
 
 
 
# What was the most exciting aspect of this project?
 
The most exciting elements of this project for our group was getting to work with and sort large amounts of data, and refactoring our methods after getting them to pass. We enjoyed getting to look at our work in different ways and problem-solve together as a team. This has solidified our understanding of multiple approaches to building this code.

 
 
 
# Describe the best choice enumerables you used in your project. Please include file names and line numbers.
 
## max_by & min_by
We found ourselves frequently utilizing the max_by and min_by enumerables to sort by the highest and lowest elements. One example of this would be in stat_tracker.rb (lines: 23 & 27) in the methods, #highest_total_score and #lowest_total_score.
 
## group_by
We used group_by a few times to arrange statistics by specific keys. For example, the method, #most_accurate_team in game_team_repo.rb(ln:128) utilizes group_by to arrange the games in the season by team_id as the key, and the game info as the value in a hash.
 
## find
The find enumerable was another enumerable we perceived to be useful in writing some of our methods. An example of this is in the method, #highest_scoring_visitor in our game_team_repo.rb (ln: 44). We set the variable highest_away_team to return the first team name that meets the condition of the highest away team id.
 
 
 
 
# Tell us about a module or superclass which helped you re-use code across repository classes. Why did you choose to use a superclass and/or a module?
 
 
 
 
# Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).
 
## Unit Test
#game_total_score in game_repo_spec.rb is a good example of a unit test because it is testing for a single method. In the method located in game_repo.rb(ln:14), we just want to calculate the away goals plus the home goals to give us an array of the total goals per game.
 
## Integration Test
We found the #percentage_home_wins and #percentage_visitor_wins in game_repo_spec.rb (lines: 53 & 57) are very solid examples of an integration test because they use multiple helper methods for their calculations.
These methods are located in game_repo.rb (lines: 56 & 60). They use helper methods, #home_wins (ln:30), #visitor_wins(ln:36), #total_games(ln:48), and #percentage(ln:52)
 
 
 
 
# Is there anything else you would like instructors to know?
 
 
 
 
# Q&A
As individuals:
 
Please include a minimum of 1 question from each group member (max: 3 questions per group member). Include these questions as a section in your project README. Your evaluating instructor will answer these in your feedback video.
 
## James:
 
## Andra:
 
## Harrison:
 
## Kassandra:

