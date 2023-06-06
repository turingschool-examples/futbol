# Futbol

## Contributors
Chris C https://github.com/topher-nullset https://www.linkedin.com/in/chris-cullinane-3200b9276/
Wil F https://github.com/fadwil https://www.linkedin.com/in/wil-fady-920b33275
Weston S https://github.com/westonio  https://www.linkedin.com/in/westonschutt/
Paul B https://github.com/pcbennett108 https://www.linkedin.com/in/paul-bennett-388540279/

## Check-in Process
morning check-in at 8:30 am MST
informal check-in during worktime 
  hitting bariers? unsure of what's next? thats what the check-in is for!

## Project Organization
https://github.com/users/westonio/projects/3
Tasks and organization belongs in GitHub projects
General questions and things like scheduling belong in Slack
Project storyboard on Miro https://miro.com/app/board/uXjVMB55lMQ=/
Pull Request Templates
    Describe your changes
    Issue ticket number and link
    Checklist before requesting a review
  - [ ] I have performed a self-review of my code
  - [ ] If it is a core feature, I have added thorough tests.
  - [ ] I AM MERGING WITH WESTONIO

## Unique Approaches
Start with 2 classes StatTracker and Parser
>The focus should be on writing clean parsers in Parser. 
>Game, league, and season methods in StatTracker would call on parser data.
>StatTracker instance methods would also call on code blocks to reduce rewriting code. 
>Code blocks could then be split into seperate classes to clean up StatTracker.
>(fewer classes in the beginning, more classes later)

Start with 4 classes ST, game_parser, teams_parser, game_teams_parser
>Parsers and logic are built into the classes based on the nature of the csv file they come from.
>(This breaks out the work very nicely for four people but could become confusing)

Start with 5 classes ST, Parsers, Games, Leagues, and Season.
>Parsers would live in Parsers for StatTracker to call
>Games, League, and Season will contain all logic for ST methods besides slicing the csv_data.
>(More complex at the start but maybe the least major refactoring, who knows?)

The runner file will deliver the CSV's to Stat tracker with .read_csv
>This creates a StatTracker object with all of the csv data
>The instance methods in StatTracker will deliver the csv slices to classes with .from_csv

We decided on what felt like the simplest approach and realized we will have to pivot as we progress through.

## DTR Links
original: https://docs.google.com/document/d/1zckxrDKgt_dMJLzHltimGCktWElfJmO8VVLp9EDuGns/edit?usp=sharing