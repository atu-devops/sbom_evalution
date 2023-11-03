# README

## Approach
I approached the task with a backend mindset at that is my core skillset. In that sense I decided to get the project up and running. Wire everything up and then look at the integrating tailwind. I left that until the end as it is not something I have used before. So in short my apprach was:
 - Create a project without activerecord. I should have created it without mini test as well but I forgot.
 - I then removed mini test and added rspec as that is what i am used to using.
 - I added the routes and basic controller strucutre.
 - Created some basic views to check everything was routed correctly and mocked a response to have some content returned to the view.
 - Once everything was wired up I wrote the core logic to parse the lab results.
 - Wrote some basic request spec to check the parsing output was as expected.
 - Then I realised the parsing logic should really be in a service object so I refactored that out.
 - wrote some specs for the parsing object
 - add some very simple error handling in the service object, really as a place holder.
 - Then I added tailwind, I had a lot of trouble with npm dependancies. I had issue with the version of webpacker and webpack I was using. Migrating/Upgrading caused further issues with postcss and babel dependancies, I got into a bit of a loop NPM is noth a strength of mind. I eventually decided to migrate to the latest version of everything. I successfully compiled and tailwind was added.
 - Following the instructions from the test I used the plugin but the code it was rendering was all squashed in the top left corner. Also the background colours were not rendering. Within the plugin UI i didn't see the emerald colour decieded to get the layout working as much as i could and deal with colours later.
 - I tried a different plugin from builder.io and that worked better. So there was some kind of serviceable layout.
 - Once there was a basic layout there it made sense to generate a partial for the form so as not to duplicate it on both pages.

## What I would do next
I tried to do this as quickly as possible as the time set for it was 45min to an hour. So as of now I would
 - add some more error handling
 - add further and broader tests (maybe capybara)
 - get a better understanding of tailwind and how to use it

## Notes
Here is a [screenshot](https://drive.google.com/file/d/1s8IzUEMGJgoW3rz4_66P-dumHn_Ap7ZN/view?usp=sharing) of figma with the plugin enabled. It doesn't display the emerald colours among the colours in the bottom right.(I'm sure it is my mistake)
