---
layout: post
title:  "Making Google Calendar work in Swift"
date:   2015-05-14 18:45:00
categories: projects
tags: swift google-calendar json
image: /assets/article_images/2015-05-14-making-google-calendar-work-in-swift/default.jpg
---

As I've been working on developing an iOS app for my Fraternity, I came across one roadblock that had almost no documentation online. At least without hours of searching and sifting through StackOverflow posts, digging up little bits and pieces that I could finally use to make a whole answer. So I thought I would post what I found worked, and do so in one place for those also searching. 

Specifically, I am attempting to access my public Google Calendar and make it available to users of my app, allowing them to see and sign-up for public events I post.

The problem with using Google Calendar API is that all documentation is in Objective-C, and using a bridging header wasn't the solution because it is impossible to find, if it exists, the framework encapsulating the hundred of header files that is the API.  

First thing you need to do after creating your app is head over to the Google Developer site and register your app with the Google Developer Console. After doing so, make a new public API access key in the “Credentials” tab. Leave the “Accept requests from an iOS application with one of the bundle identifiers listed below:” section blank, allowing any request since I am only accessing a public calendar.

Now you can go into wherever you want your calendar feed to show up, in my case my ViewController.swift: 

{% highlight swift %}
 let url = NSURL(string: “https://www.googleapis.com/calendar/v3/calendars/{CalendarID}/events?key={API-Access-Key}”)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            var error: NSError? = nil;
            
            
            if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
                if let items = json["items"] as? NSArray {
                    for item in items {
                       var obj = CalendarObject(json: item as! NSDictionary)
                   }

                }
            }
            
        }
{% endhighlight %}


CalendarID is generally the Gmail address associated with the Google Calendar, but can be found by going to your Google Calendar and clicking on “Calendar Settings.” Also, you will want to change your error variable into something more user friendly than “nil.” ;)


You can store specific data from the JSON feed you got in the code above into a class as I do with CalendarObject.swift:

{% highlight swift %}
class CalendarObject {
    
    var endTime: String?
    var location: String?
    var startTime: String?
    var summary: String?

    
    init(json: NSDictionary) {
        if let end = json["end"] as? String {
            self.endTime = end
        }
        if let loc = json["location"] as? String {
            self.location = loc
        }
        if let start = json["start"] as? String {
            self.startTime = start
        }
        if let sum = json["summary"] as? String {
            self.summary = sum
        }
    }
}
    {% endhighlight %}

   
