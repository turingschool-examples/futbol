# Futbol

##Mod 1 Group Project
###by The Fantastic Four
*(Michelle Foley, Ross Perry, Rostam Mahabadi, Stella Bonnie)*

**Design Strategy**
We initially created classes associated with each of the CSV files provided (Game, Team, GameTeam) as well as a StatTracker class to bring the methods from each respective class together. The statistics methods from iteration 2 were each created in the corresponding class. In the cases where we needed to access multiple classes, we wrote corresponding methods in each class and then brought them together in the StatTracker class. We relied heavily on class methods since we were most often generating statistics based on all the instances of a class (i.e. the entire CSV).

Once we verified that all of our methods were performing as expected in all classes, relying heavily on TDD, we began refactoring to reduce repetition, shrink methods and classes, and improve speed. To accomplish this we utilized modules, inheritance, and added some helper methods that would work on instances rather than the entire class. For inheritance, all the classes that were created from a CSV had 3 methods in common:

* self.from_csv (which instantiates objects in the respective class by reading the CSV)

* self.all (which gives us access within the class to all of the instances by means of an instance variable)

* self.find_by (which allows us to search using game_id)

Using inheritance for these methods was pretty straightforward since they were exactly the same across the three classes and were being used to set _state_ and _behavior_. The repetition we saw in methods across the classes was not as straightforward and we decided to write modules since they were strictly dealing with _behavior_.

... 
