# ExpenseTracker
JHUB Coding Scheme Module 2 - App Development

Your assignment is to create an expense logging Mobile application for either iOS or Android using native technology frameworks. For iOS this is Swift and Xcode (not UI Kit), and for Android is Kotlin and Android Studio.

The app should allow a user to:

1. take photos of their receipts
2. save them with a metadata timestamp of when they were taken
3. labelling how much money is to be claimed from each receipt (manually entered by the user)
4. display a running total of the amount to be claimed
 

Add your source code to a version control tool (such as GitHub) and include a link to the project code and any other relevant supporting evidence in your idea submission (screenshots of the app being run in development environments such as Android Studio or Xcode would be helpful, but are not necessary if the application can be built using these tools). The complied project is not required.

The app should contain only unclassified information and be easy to use. It should be built using Swift or Kotlin, but you should not pay to have it published or deployed into the app stores(!). The mark-scheme is attached on the right-side of this page, and we expect completion of the project to take around 20 hours.


Need to fix:

1. Image file size (too large) - changed to compressed JPEG
2. Ability to delete images - images delete as record deleted
3. Option to have no image without crash - fixed
4. Overlay timestamp on image - overlay creaded but displaying timestame from Date
5. Check timestamp from metadata - timestamp from photolibrary but not camera
6. Create days since claim
