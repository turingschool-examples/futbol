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
We used a parent class called repo.rb to house the initialize method that the subsequent files then inherit and have access to. We used a superclass instead of a module because we wanted to pass down common behaviors from the parent class to the sub-classes and cut down on redundancy of our code. As our code is now, a module could really only interact with a specific class instead of multiple classes.
 

 
# Tell us about 1) a unit test and 2) an integration test that you are particularly proud of. Please include file name(s) and line number(s).
 
## Unit Test
#game_total_score in game_repo_spec.rb is a good example of a unit test because it is testing for a single method. In the method located in game_repo.rb(ln:14), we just want to calculate the away goals plus the home goals to give us an array of the total goals per game.
 
## Integration Test
We found the #percentage_home_wins and #percentage_visitor_wins in game_repo_spec.rb (lines: 53 & 57) are very solid examples of an integration test because they use multiple helper methods for their calculations.
These methods are located in game_repo.rb (lines: 56 & 60). They use helper methods, #home_wins (ln:30), #visitor_wins(ln:36), #total_games(ln:48), and #percentage(ln:52)
 
 
 
 
# Is there anything else you would like instructors to know?
Being the first larger group project, it was difficult to balance all of the moving parts and challenges with workflow and schedules. There was a lot of collaborative learning and problem-solving together. Having mentors and teachers to help us along the way was immensely helpful!

We also could not get the worst_offense method to work in the spec_harness despite many attempts - we would like feedback on this if possible.
 
 
 
# Q&A
As individuals:
 
Please include a minimum of 1 question from each group member (max: 3 questions per group member). Include these questions as a section in your project README. Your evaluating instructor will answer these in your feedback video.
 
## James:
Is it industry standard to be working with a spec_harness? If not, what is most common practice? What is the typical workflow in the industry regarding github and branches, as well as commit messages? 
 
## Andra: 
How do teams commonly approach refactoring processes, especially when a refactor has an impact on many other tests? What is the ideal timeframe to allow for refactoring in the future?
 
## Harrison:
If we had more time on this project, I think a good potential for refactoring would be to use modules to house our methods and logic for the various statistical categories to reduce the responsibility of stat_tracker. Would this be in line with “best practice”? Would more inheritance be better used instead?
 
## Kassandra: 
What would be better to use in the context of this project - inheritance or modules? What would be the best way to approach a similar project in the future (one with a lot of data), especially in the workplace?
