# MIDTERM: Personal Gallery Static Application made in Flutter

Install dependencies by typing: `pub get`

Sections of the app
1. **Home page (brain icon)** - this is where photos with caption lives. It emphasizes the interests and life's philosophy of the owner.
    1. *carousel_slider* is used to setup the photos in a vertical scrolling manner with a minimal animation and automatic sliding feature.
2. **Favorites page (heart icon)** - the photos here contains a more personal touch inside the life of the owner.
    1. *ListView* is used here adding blue border to each pictures
3. **Time check** - scrolling can be a mindless and endless task so one needs to check the time and date.
    1. *DateFormat* is used to get the time and date in the desired format
4. **Photos of the owner** - as already said, it includes the photos of the owner.
    1. The layout used here is *GridView* where each cell contains a picture