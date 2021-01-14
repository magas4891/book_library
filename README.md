The Book Library application

The application is a simple book application that allows a user to add and remove books from their library. These books can be downloaded for reading once a user is subscribed. Accessing a library is only possible if a user is subscribed.

A user is presented with buttons for adding a book to their library. As you can guess, to do this action a user first needs an account. Upon clicking the "add to library" button a public-facing user (someone with no account) is redirected to a signup page of which we implement using the Devise gem. 

A nice callback function from Devise allows us to redirect a user upon successfully signing up. In this case, we redirect a user to a pricing page that features three plans to choose from. Each plan has its own parameters associated with it. Upon clicking the "subscribe" button on any of the tiers, the user is redirected to a payment page carrying over the necessary parameters to hook into Stripe with. 
