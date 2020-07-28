# Futbol

As a deliverable for your refactoring and reorganization, include a README in your GitHub repo that describes your design strategy. This could be a narrative description of your design, or a graphic representation.

<b><u><h1>Design Strategy</u></b></h1>
<br></br>
<b><h2>Library & test files</h2></b>
<p>As far as organizing the library goes, we decided that it'd be best to approach all of it in the most organized fashion, mimicking the structure of a tree.</p>
<br></br>
<p>What this means is, the <b>runner.rb</b> file is where it all begins. Everything else 'branches' from that one file. Doing this adheres not just one principle of object-oriented programming, but two; 1) encapsulation and 2) abstraction.</p>
<br></br>
<p>After one decides to 'run' the 'runner.rb' file, the first place Ruby goes is the 'stat_tracker.rb' file. This file adheres to the 'one function per method' principle. Each method in stat_tracker can be easily explained in one sentence. After that, it depends on which method one chooses, but they all 'branch' off into various locations to make sure files aren't communicating with each other within the 'stat_tracker.rb' file. We'd have the program go out into the module 'modable' because it keeps our methods to the 'one function per method' principle.</p>
<br></br>
<p>Some methods run in the 'modable' module take information from various CSV files. This, again, makes sure the 'stat_tracker' file has all of it's methods with just a single responsibility, and it makes sure the files don't need to communicate with each other.</p>
<br></br>
<p> The main point of all of this being; have the methods within 'stat_tracker' carry one responsibility, make sure the files don't need to communicate with each other, and keep the code as clean as possible. All classes are within 150 lines of code as well, making sure no class is too lengthy to understand.</p>
<br></br>
<p> An important point to make is because the CSV files are so long, it wouldn't be efficient to read each line of every file and grab what we need (creating a method that will open the file and read it to find what it needs). A more efficient approach, and the one we went with, was to instantiate the CSV file we needed in a specific file (like game_manager.rb) and create an array or hash within that class. That way, if we need it, we can instantiate the class to read the file right away and store it as a hash or array.</p>
