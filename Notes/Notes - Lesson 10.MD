Passwords Left Out In The Open...

We have added a new field to our ad_schema called "show_password" which we can set to either true or false. 

With this field included, we added a line to our Create-ADUser function within our gen_ad script that adds a description to any user that has show_password set to true, within this description we have included a prompt with the users password within it. 

Once done, we uploaded all this to the Domain Controller and then used the Python collector for Bloodhound (See Lesson 06) with a set of user details already known to us to scrape all the Domain data we can get from the environment. 

Once this data was collected we fed this into Bloodhound, which made it very easy for me to query users and also see any Descriptions set for users (if applicable), which in our case, contained a set of credentials. Pwned. Happy days :)