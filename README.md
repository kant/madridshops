# Madrid Shops

iOS application that shows information of Shops in Madrid, even when the user has no Internet connection
Developed with Xcode 9.1 & Swift 4.

## Requiremets

Requirements:
1. When starting the App for the first time, if there's Internet connection it will download all information from the Shops access point (see below), including all images.
2. The App will cache everything locally: images, data, etc. Even images of the maps. See below for tips
3. Cache is never invalidated, so once everything has been saved, set a flag and never ever access to the network again
4. If there's no Internet connection a message will be shown to the user.
5. While caching the App will show an Activity indicator or other loader. Until you finish caching you don't get to the Main menu.
6. The app will have a main menu screen where we'll add one button & a logo. The button takes us to the list of shops.
7. The list of Shops will show in the upper 50% screen a map with one pin for each shop.
8. The list of Shops will show in the lower 50% screen. Logo to the left, background image taking all the row, shop name in the front. Tapping a row takes us to the detail shop screen.
9. All info should be read from a Core Data database
10. If you tap on a pin in the map a callout will open with the logo +
shop name. Taping the callout takes us to the detail shop screen.
11. The map will be always centered in madrid, showing also the user
location
12. All data is at least in Spanish & English: should cache all and
display in Spanish (if that's our phone's language) or English
otherwise
13. Shop detail screen should show shop name, description, address,
and a map showing the shops's location without any pin

## LICENSE

MIT - Licence

Copyright (c) 2017 Diego Freniche

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
