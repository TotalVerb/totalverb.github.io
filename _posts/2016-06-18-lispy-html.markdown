---
layout: post
title:  "Lispy HTML"
date:   2016-06-18 00:13:46
categories: tech
tags: [lisp, html]
---

I’ve become convinced that s-expressions are one of the best ways to encode
data. And HTML, in many ways, is data.

It seems like life would have been so much easier if the powers that were
decided to use this syntax:

{% highlight clojure %}
(html ([lang "en"])
  (title "An HTML Page")
  (p "This is a simple HTML page."))
{% endhighlight %}

instead of

{% highlight html %}
<!DOCTYPE html>
<html lang="en">
  <title>An HTML Page</title>
  <p>This is a simple HTML page.</p>
</html>
{% endhighlight %}

Furthermore, the former syntax has the potential to allow macros—which can not
only simplify complex documents, but also save HTTP traffic. Finally, if this
were the format of HTML, then JavaScript would indeed look a lot like a lisp, as
so many claim it is.

But that’s just talking the talk. I’d rather walk the walk! I’ve rewritten my
résumé with s-expressions, which are then compiled into plain HTML by a
currently-unreleased Julia tool. (Julia is basically a lisp anyway!) More to
come in the future.
