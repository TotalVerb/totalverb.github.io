---
layout: post
title:  "Java and JavaScript"
date:   2016-08-30 15:46:52
categories: tech
tags: [js, java]
---

There’s a popular saying out in the wild:

> Java is to JavaScript as car is to carpet.

I don’t know where this saying comes from, but I’ve seen it around a few times.
And it’s quite true.

That said, it’s clear that Java was a primary source of some of JavaScript’s
misfeatures. It’s illuminating to look at some of them below.

## A Month in Advance

A date is a human thing. Computers generally keep track of time with timestamps;
a monotonically increasing integer keeping track of the number of time units
elapsed since some epoch. But humans don’t understand what 1472573807691 means,
so we use a more hierarchial system to keep track of time.

With that in mind, what should `new Date(2016, 8, 30)` mean? August 30, 2016, of
course? If only... it actually means 2016-09-30T04:00:00.000Z. This is again
another holdover from one of Java’s greatest mistakes.

It is really inexcusable to index months starting from zero, and not at the very
least try to maintain consistency by indexing years and days too. It is really a
shame that even having all three fields off by one is a better situation that
having just one field off by one. Even better, we could perhaps realize that
dates are for humans, not computers, and not do any of this silly indexing to
begin with—1 means January, as any five-year-old knows.

In JavaScript’s defense, pretty few languages have dates that get this right.

## How Long is a Chinese Name

Truth be told, my browser and font (as of present) cannot display these
characters; nor do I know what they mean: 𠀀𠀗. What I do know is that there are
two Unicode scalar values there. Count them: 2. If you don’t believe me, let’s
ask the computer:

### Python 2

{% highlight python %}
>>> len(u'𠀀𠀗')
2
{% endhighlight %}

### Python 3

{% highlight python %}
>>> len('𠀀𠀗')
2
{% endhighlight %}

### Julia

{% highlight julia %}
julia> length("𠀀𠀗")
2
{% endhighlight %}

### Ruby

{% highlight ruby %}
irb(main):001:0> '𠀀𠀗'.length
=> 2
{% endhighlight %}

OK, the point’s been made. There are clearly two unicode scalar values there.
But JavaScript has a mind of its own:

### JavaScript

{% highlight javascript %}
> '𠀀𠀗'.length
4
{% endhighlight %}

Don’t get me wrong — I love JavaScript — but this is a clear WTF. And it has
Java to blame for this behaviour. And Java’s (understandable, given the lack of
clarity at the time) decision to make its `String` type effectively an array of
unsigned 16-bit integers, is in many ways a reflection of the poor understanding
of [utf-16].

And this is not merely an academic concern. While the characters I used above
are obscure CJK ideographs, there are a whole class of additional non-BMP
characters that cause issues with JavaScript’s string length counting, including
most emoji. I can only say that I am rather 😞 at this poor handling.

## A Label You Can’t Go To

Both Java and JavaScript have a peculiar feature: labels. This is of course not
so strange. C has them too, after all. But neither Java nor JavaScript actually
have a `goto` statement.

This means that labels are practically worthless, except in a single case: You
can `break` (or `continue`) out of a loop that isn’t the innermost one by
identifying it with a label. So much for not having `goto`. After all, breaking
out of arbitrary loops is just about the worst thing you can do with `goto`
statements.

{% highlight javascript %}
mylabel: do {
  do {
    break mylabel;
  } while (false);
} while (false);
{% endhighlight %}

Of course, nobody knows about this feature. And that’s probably a good thing,
because whenever code is trying to break out of arbitrary loops, that’s a sign
that the code needs to be refactored.

[utf-16]: http://programmers.stackexchange.com/questions/102205/should-utf-16-be-considered-harmful
