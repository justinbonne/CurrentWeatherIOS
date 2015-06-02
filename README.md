#CurrentWeatherIOS

##Scope
An small, single page application that uses geolocation to 
get the current weather conditions using the
[forcast.io](https://developer.forecast.io/) api.

##Implementation
The main ViewController is a CLLocationManagerDelegate. When the app loads it
starts looking for the location, shows a loading screen and instantiates an
empty Forecast object as its property. The Forecast class handles
communications, data storage and formating for the forecast.io api call. The
Forecast class uses NSURLConnection sendSynchronousRequest to make the call to
the api. Once the ViewController receives a location it stops asking for the
location and sends a message to its forecast object to make a call to the
forecast api and load the response into the forecast objects properties. Lastly
it sends a messaged to itself to update the labels in the GUI and hide the
loading screen when it is complete.

