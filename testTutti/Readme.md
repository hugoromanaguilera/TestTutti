
App Specification: uGo!
iOS Developer Nanodegree

uGo! allows users to record when and where they arrive and leave the office. A history of these arrival and departures is stored, along with location data. Users can also view their history using the app. 


The app will have five view controller scenes.
●	Login Screen: Users will log-in using their company user account and password.
●	Record Entry View: Allows the user mark an entrance or departure.
●	History View: Allows the users to view a history of their arrival and departures entries, their locations, and the application used.
●	Map View: Shows a pin on a map of where an entry was recorded.
●	Configuration View: Allows users to logout.

The scenes are described in detail below.

Login Screen
If there is no current session, when the app first starts it will open to the login screen. Users will be able to enter their company username and password and hit “enter” to begin a session. 












Record Entry
The Record Entry view is where users can record an entry by choosing either “In” (“Record Arrival”) or “Out” (“Record Departure”). When one of these buttons is chosen, the type of entry (i.e. departure or arrival) is recorded with a date, timestamp, and location information. This information is this entry is stored locally in Core Data and it is sent automatically to a web service. 

At the bottom of the screen, the user’s most recent arrival and departure are displayed with a date and a timestamp, as well as three icons: Record, History, and Configuration. These icons are always available to the user to navigate between these three views.





History
When the user selects “History” a list of recent entries is displayed. Each entry is displayed with the date and time it occurred. An icon indicates if it was an arrival or departure and the application used to make the entry (iOS, android, company software, etc). When an entry is selected, a map view window appears and shows a pin where the entry was recorded.








Map
This view, which is accessed by clicking on an entry in the History section, shows an unmovable pin on a map where the entry was recorded. If location services are enabled, the map shows the user’s current location. Users can navigate and zoom in on the map with standard pitch and drag gestures. 





Configuration
When the user selects the “Configuration” icon at the bottom of the screen, the Configuration view is displayed. There is a “Session” section that displays the username of the current user and provides the option to logout from the session. 





















