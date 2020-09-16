# Futbol
<img src="https://i.ibb.co/P4K7Lkz/open-wide-soccer.gif" alt="open-wide-soccer">

## Table of Contents
- [Overview](#overview)
- [Design Strategy](#design-strategy)
  - [Initial Organization](#initial-organization)
  - [Refactored Organization](#refactored-organization)
- [Contributers](#contributers)
- [Make Your Own Futbol](#make-your-own-futbol)

***
## Overview
Futbol is a program which utilizes CSV data from a fictional soccer league to pull various statistics based on individual teams, games and seasons. Working with a team of four, our goal was to build object-oriented code that maintained readability and organization. Our strategy in tackling the various methods included using a "red, green, refactor" approach and we relied heavily on Test-Driven Development and robust testing techniques such as Mocks and Stubs. At the outset of the project we focused on building a `StatTracker` class which contained the statistical logic, then later we reorganized our program to follow the Single Responsibility Principle by utilizing multiple classes and modules.

***
## Design Strategy
The basic thrust of our design strategy was: make a big mess as long as it works/passes testing and reorganize/refactor for clarity later. Here's the process:

### Initial Organization
Initially our organizational hierarchy contained a single class, the `StatTracker` which was responsible for everything the program does. This included: reading in the CSV data and creating CSV data tables, creating variables to hold the various paths to the CSV files and all of the statistics logic. All said and done? We clocked in at 582 lines of code in the original `StatTracker`. (ouch)

### Refactored Organization
<img src="https://i.ibb.co/35KRn0W/Futbol.png" alt="futbol-org-chart">

We reorganized our project by breaking out the methods we had built in the `StatTracker` into 6 new classes and, eventually, 3 modules. Our new classes were designed to be Managers, or data objects, passing up data to the `StatTracker` which essentially works as a traffic director. The structure, as pictured above, handles the following responsibilities:

`StatTracker`
- Top of the hierarchy, the `StatTracker`creates manager objects and passes the CSV data paths to the specific managers. It also contains methods which act as a 'traffic director' and calls to the managers to do the heavy-lifting of actual statistics calculations.

**Manager Layer (or, the overburdened and underpaid)**
- This layer contains the `TeamManager`, `GameManager`, and `GameTeamsManager`. These classes are responsible for actual calculation work and create the individual `Game`  `Team` and `GameTeams` objects. This is useful so that we're only reading in the data once, then storing it in the individual objects themselves. The manager layer also sends up its calculations to the `StatTracker` when its specific methods are called.

**Data Collectors**
- Our data collectors are the `Game` `Team` and `GameTeams` classes, which take in the CSV data upon initialization and are responsible for storing all the data in individual objects.

**Modules**
- `Findable`
  - `Findable` is a module we use as a mixin. It holds one specific method used across classes to find specific teams by team id. We would have liked to make this module more robust, and it would be on our wishlist to refactor some further methods to build this out and take further responsibility from the manager classes.
- `AssistantToTheGameTeamsManager`
  - This module contains all of the helper methods that we needed to build out the `GameTeamsManager` logic, one of our biggest classes. We utilize this as an organizational tool to keep responsibility of each class clear.
- `LeagueStatistics`
  - We are utilizing this module to organize our league statistics calculations. Another organizational tool to group together similiar methods for clarity and readability.

***
## Contributers
- Sage Gonzalez (he/him)
  - [Github: SageOfCode](https://github.com/SageOfCode)
- Shaunda Cunningham (she/her)
  - [Github: smcunning](https://github.com/smcunning)
- Taylor Phillips (he/him)
  - [Github: taphill](https://github.com/taphill)
- Zach Stearns (he/him)
  - [Github: Stearnzy](https://github.com/Stearnzy)

***
## Make Your Own Futbol
- [Main Futbol Project Repo](https://github.com/turingschool-examples/futbol)
- [Futbol Spec Harness](https://github.com/turingschool-examples/futbol_spec_harness)

<img src="https://i.ibb.co/cYPFJm0/soccer-penguin.gif" alt="soccer-penguin">
