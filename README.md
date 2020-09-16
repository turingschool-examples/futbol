# Futbol

- This project is designed to be a collaborative project.
- Participants are encouraged to understand and implement OOP principles in order to meet project test time requirements.
- Participants will be accessing and organizing data from csv files in order to create sport analyst style method outputs.

## Project Structure Overview:

### Stat Tracker Initialization
- When we initialize the Stat Tracker class, we use the Csv module to create a table with the information from the CSV files by creating an object for each line of data. We feed in the data in the form of a hash, and the corresponding class instantiates the objects.
- For the game files and teams files we created hashes where the game_id and team_id act as keys and each object is the value. For the game team files we created an array because the game_ids are not unique.

![alt text](https://user-images.githubusercontent.com/7945439/93382660-aa1e2b80-f81f-11ea-86f9-a945d8de5fe3.jpg "stat_tracker")

### Calling Methods On Stat Tracker
- While all the methods live in the Stat Tracker, when a method is called it will make a call on the corresponding statistics class. For example, if we call the best_offense method from the Stat Tracker, it will call the League Statistics class, which in turn inherts a helper method from the League Stat Helper class to return the value requested.

![alt text](https://user-images.githubusercontent.com/7945439/93383277-9fb06180-f820-11ea-8f6b-801232501798.JPG "work_flow")

Special Note: In order to run in under 5 seconds in the RSPEC test, please close all other applications.


## Contributors:
Jose Lopez - [Github](https://github.com/JoseLopez235)
Michael Foy - [Github](https://github.com/foymikek)
Sheryl Stillman - [Github](https://github.com/stillsheryl)

Starter repository for the [Turing School](https://turing.io/) Futbol project.

- optional: install SimpleCov to test
