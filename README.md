# Futbol
Starter repository for the [Turing School](https://turing.io/) Futbol project.

# CONTRIBUTORS
Karl Fallenius
  - insert github profile
  - insert LinkedIn profile
    
James Cochran
  - insert github profile
  - insert LinkedIn profile
    
Cory Bretsch
  - [GitHub Profile](https://github.com/CoryBretsch)
  - [LinkedIn Profile](https://www.linkedin.com/in/cory-bretsch-12591b16b/)


# README REQUIREMENTS
### DTR & RETRO
  - [DTR](https://docs.google.com/document/d/1FACITYUJOXfrlqmo62Xsbf1nut_gJ6O829bR0uazS5U/edit) completed on June 3rd, 2024
  - [Re-DTR](https://docs.google.com/document/d/1FACITYUJOXfrlqmo62Xsbf1nut_gJ6O829bR0uazS5U/edit) completed on June 6th, 2024
  - [Retro](https://easyretro.io/publicboard/YEugqgDd8JcsiJopBf4DhiOR6Cm2/9a4f3f19-daf1-4d10-9e1f-1ec9c8a89788) completed on June 7th, 2024

### CHECK-IN PLAN
  - We plan to conduct daily stand-ups 5 min before class. We will complete our first retro and Re-DTR on thursday, June 6th during the class-scheduled time. 

### PROJECT ORGANIZATION AND WORKFLOW
  - We will be using an [EasyRetro](https://easyretro.io/publicboard/YEugqgDd8JcsiJopBf4DhiOR6Cm2/5bc57278-d612-429a-8138-c199ea17cebd) Kanban board to help organize tasks.
  - We will follow a branch naming convention of 'person_first_name/feature_working_on'. An example is 'James/highest_total_score'.
  - We will require 1 person to review code and merge a PR

### APPROACHES TO PROJECT ORGANIZATION 
  - We looked at a variety of different project management tools and approaches before deciding a kanban board would fit our needs the best, and easyretro would be an excellent tool for implementation. So far it seems to be working really well for us.

### APPROACH TO CODE DESIGN
  - We discussed a number of different code design approaches. A great example is whether to work with data ojects being pulled from the CSVs by using hashes and assigning values as instance variables, or alternatively, skipping the hash step and treating the data objects as individual objects with their own attributes. We decided to go with the latter option. Our goal is to keep everything as simple and straight forward as we possibly can.
  - Our original plan was to create 7 class: one for each .csv data file, a StatTracker class, and a Game, League, and Season Statistics class. After jumping into the code and meeting with Kat for a check-in, we are looking at including the latter three classes as a possible refactor option. This design decision aligns with the YANGI principle.
- We will be using TDD, as well as "red, green, refactor" to establish functionality.
