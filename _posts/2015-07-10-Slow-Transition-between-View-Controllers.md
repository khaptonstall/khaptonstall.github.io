---
layout: post
title:  "Slow Transition between View Controllers"
date:   2015-07-10 01:00:00
categories: ios-programming
tags: swift storyboard transition uiimage
image: /assets/article_images/2015-05-14-making-google-calendar-work-in-swift/default.jpg
---

If I can only save 1 person a little bit of time with this blog post, I
have exceeded my expectations! The problem I was facing was seemed like
it would be a common problem, yet I found nothing online that helped
(stackoverflow was about the extent of my search). 

Here was my setup. I had a Navigation Controller embedded in
ViewControllerA, which allowed users to seque to ViewControllerB. Inside
ViewControllerB I had a UIImageView as the background with the image set
to Aspect Fill. Everything is fine so far. Yet when I hit the back button on 
ViewControllerB's navigation bar, the transition to ViewControllerA was choppy,
meaning B slid to the right, paused about a quarter of the way left to go in its
transition, then continued out of view.

The choppy-ness was actually caused from the UIImage not clipping to ViewControllerB, which
can be fixed with one simple, yet maybe not so obvious fix. Simply check the box below in the
storyboard.

![Check "Clip Subviews"]({{ site.url }}/assets/images/ClipSubview.png)


-kh 



