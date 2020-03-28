# Medical Calculator for Doctors

## Inspiration
With the increased number of people infected with the coronavirus, the doctors are facing more problems about what kind of treatment will be the best for each patient based on their individual epicrisis and weight. The app is inspired by the doctors who are working unremittingly every day to save lives. That is why the app was designed to save them time for searching the right dosage, which they can use for other patients. 

## What it does
The application is connected with an online JSON file, which contains a different type of medicines. The JSON file can be updated (add or remove medicines from the list) online, to facilitate the usage of the app. The only requirement is an internet connection. I decided to make it through a JSON file instead of core data, because the list of medicines can be updated easier without a need for an app update. When the doctor opens the app, a list of medicines called from the JSON file will appear like a list on the screen. There is a search bar that can be used to find a medicine based on its name. When the desired medicine is selected, a new window is open, where the doctor can select how many KG is the weight of the patient. I have discussed the idea with 3 different doctors, who informed me that 90% of the treatment for every patient is based on their weight. That is why I have created a pickerView which can be used from the doctors to select the desired KG of the patient and based on it, prescribe the right dosage. 

In summary, this is a mobile dosage calculator, which calculated the needed dosage of medicines for every patient based on their weight in KG. 

## How I built it
I have built this application using the latest version of Xcode and Swift. The framework used is SwiftUI and to create the list with medicines I used JSON format. 

## Challenges I ran into
The most challenging thing was to find out how the dosage is created for each patient. I found out that most of the medicines are prescribed based on the Age and the Weight of the patient. However sometimes if the patient has more diseases, considering the right medicine is more difficult. For example pregnant women or people with chronic disease. But after discussing it with 3 doctors, I was advised that for the Coronavirus and the initial version, the calculator should be designed for the patient's weight only.

## Accomplishments that I'm proud of
I am proud that I created such kind of calculator because it is a simple idea, but it has never been done before and it will facilitate the work of many doctors. The application can be also applied to any other type of treatment, not only for the Coronavirus, that is why I find it very useful and practical.

## What I learned
I learned that in order to change the world, we don't have to create complicated stuff. Sometimes the small things and ideas are forgotten because they are too simple but in reality, they can be even more effective.

## What's next for Covid Medical Calculator
The next steps are to create a new view, where the doctors can see the side effects of the medicine, thus the doctors can decide whether the selected medicine is really appropriate for the patient or not. I believe that the application solves a real-life problem and by adding some more features it can apply for FDA approval and be used as a certified application in the hospitals and by this facilitate the work of millions of doctors around the world.
