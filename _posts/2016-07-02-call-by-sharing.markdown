---
layout: post
title:  "Call by Sharing"
date:   2016-07-02 21:12:30
categories: tech
tags: [js, julia, py]
---

Most people know of two calling [evaluation strategies]: call-by-value and
call-by-reference. Lost in the noise is how the most common evaluation strategy
today is really neither of the above. Indeed, many languages, including
JavaScript, Java, Julia, Python, Ruby, and countless more, use the
“call-by-sharing” evaluation strategy.

In many ways, call-by-sharing is the most intuitive evaluation strategy. It
captures the semantics where the caller of the function shares objects with the
function being called. The called function can mutate those objects so long as
the objects themselves are mutable. Because the objects are shared, any changes
will be reflected in the calling function. This convention is applied to all
objects being passed.

For immutable objects, call-by-sharing is indistiguishable from call-by-value.
Indeed, the key to functional programming is that aliasing (the result of
sharing objects instead of copying them) is always 100% safe. This is achievable
by forbidding mutation. A class of powerful functional data structures exist
that exploit this efficiency. These data structures can usually be efficiently
updated without destroying the original copy, because the update aliases large
parts of the original data structure instead of mutating it.

This nuance with immutable objects is the source of much confusion. For
instance, the following JavaScript code mutates the array:

{% highlight javascript %}
function mutateArray(A) {
  A[0] = 0;
}
A = [1];
console.log(A);  // [1]
mutateArray(A);
console.log(A);  // [0]
{% endhighlight %}

whereas the following does not mutate the number:

{% highlight javascript %}
function mutateNumber(n) {
  n = 0;
}
n = 1;
console.log(n);  // 1
mutateNumber(n);
console.log(n);  // 0
{% endhighlight %}

A common but incorrect explanation is that the semantics in JavaScript for
passing numbers and arrays are different. Some claim that numbers are passed by
value, whereas arrays are passed by reference. Rather, it is more accurate to
say that both arrays and numbers are passed by sharing. Whereas arrays are
mutable, numbers are not.

In the first example, the syntax `A[0] = 0` is a mutation of the array. The
array does not because a different object; it is the same object as before, but
its first element is changed. In the second example, the syntax `n = 0` is very
different. It does not mean “change the value of this number to `0`”; instead,
it means “rebind the name `n` to the new value `0`”. This subtlety is the source
of much confusion. In languages with call-by-sharing semantics, names are often
distinguished from objects. Names are bound to objects, and a name can be
rebound to a different object using an assignment keyword. Assignments do not
affect the object the name was originally bound to.

Indeed, if we had written our first example as

{% highlight javascript %}
function mutateArray(A) {
  A = [0];
}
A = [1];
console.log(A);  // [1]
mutateArray(A);
console.log(A);  // [1]
{% endhighlight %}

then we would have seen a similar result as our second example. Here we are no
longer mutating the array; we are now binding the name `A` to a new array.

There is a wealth of resources online that claim that Java is call-by-value, or
that Ruby is call-by-reference. These languages are both call-by-sharing. So are
these resources wrong? In fact, the former is not wrong. The latter is a little
bit of a stretch, but there is some meaning in the nonsense. Rather, this
exposes some nuance about what exactly is a value, and what exactly is a
reference.

## Java is call-by-value

In Java 1.8, there are exactly 9 user-visible value types: `byte`, `short`,
`int`, `long`, `float`, `double`, `boolean`, `char`, and `Object`. The first 8
of these are known as the primitive types. Each of these types can be
represented as a machine integer of various fixed sizes. All the primitives
represent themselves, but `Object`s are more interesting. `Object`s can be
thought of as effectively pointers to another memory location. That means that
`Objects` are just numbers, like `long`s are. However, these numbers do not
contain the user-facing substance of an `Object`, but rather the location of the
user-facing substance. They are still values deep down—but their values are not
directly exposed to the user.

This understanding of what an `Object` really is helps to understand much of the
behaviour of objects. For instance, even if two `Object`s have identical
internal structure (like, say, two `String`s that contain the same contents),
they might not test `==`! This is a common “gotcha” for new Java programmers,
who try writing

{% highlight java %}
if (myString == "Hello World") {
  System.out.println("myString is Hello World!")
}
{% endhighlight %}

The conditional here, to their confoundment, can be false even if `myString`
also contains `"Hello World"`. Why is this? Because even if the two `Object`s
have identical user-facing structure, they might be stored in different
locations in memory, and hence not have the same value. And in Java, the `==`
comparison operator compares the values of `Object`s, as it does with any
primitive type. This is why Java programmers need to instead using the
`.equals()` method to compare the substance of `Object`s.

Now it might be clear why Java programmers often call their language
“call-by-value”: because it is! However, from a programmers perspective,
treating `Object`s as memory addresses is often not helpful. If I have an
`Object` that represents a complex number, its value—as far as I’m concerned—is
the number itself, not the memory address where the number is stored. Although
“call-by-value” is accurate from a low-level viewpoint, it is more helpful for
the programmer to think in terms of `Object`s’ substance than in terms of
pointers. And when we think of `Object`s’ and primitives in terms of their
user-visible behaviour—in which case primitives behave quite similarly to
immutable `Object`s—it leads to the inevitable conclusion that Java is indeed
“call-by-sharing”.

## Ruby can look like call-by-reference

To call Java’s behaviour call-by-value is defensible. In strictest terms, to
call Ruby’s behaviour call-by-reference is not.

Indeed, Ruby has the same semantics as Java:

{% highlight ruby %}
def mutate!(x)  # a little misleading 😉
  x = 0
end
x = 1
mutate! x
puts x  # 1
{% endhighlight %}

At this point it is clear that Ruby is _not_ call-by-reference. This is clear
if we consider the equivalent C++ code, which _is_ call-by-reference:

{% highlight C++ %}
void mutate(int& x) {
  x = 0;
}
x = 1;
mutate(x);
std::cout << x << std::endl;  // 0
{% endhighlight %}

But why then do so many sources claim that it is? They are wrong, but there is
meaning in their madness. Firstly, there is no concept of a primitive type, as
with Java. All objects are first-class objects and have similar behaviour.
Indeed, in the most simple implementations, all objects are internally stored as
what are effectively pointers. Since all objects are references, therefore all
calls pass some kind of reference.

Further confounding the situation is that Ruby has no immutable types. Rather,
immutability is a property of the instances. Some types are practically
immutable; there is no real standard way to mutate a numeric type, for example.
But theoretically, the semantics permit mutation of all unfrozen instances. This
makes calling the behaviour call-by-value more confusing than it is
illuminating.

As mentioned earlier, [Ruby is not call-by-reference]. Rather, it is more
accurate to call this behaviour call-by-value-of-reference, which is just a
fancy way of saying call-by-value. But this is needlessly confusing and
low-level. Indeed, Ruby’s semantics are identical to those of Java and
JavaScript. It is call-by-sharing.

## Semantics vs. Implementation

Above I had explained how various languages have call-by-sharing semantics.
Sharing, it would seem, implies that the objects being passed are located in the
same memory location. This idea is false.

Indeed, one _implementation_ of sharing is to place two objects in the same
memory location. Then, any mutation on one object would mutate the other.

But another, equally valid, implementation is to place two objects in different
memory locations, but to proxy mutations on one object to the other. This may
sound stupid—why do extra work, after all? But the user is none the wiser. The
_semantics_ of both implementations are identical.

Many languages that call-by-sharing do not necessarily share some things at all.
Java does not share its primitive types; those are immutable, so copying them is
the same as sharing them from the user’s perspective. And copying a number
provides much faster access than copying a pointer to a number allocated on the
heap somewhere.

For efficiency reasons, JIT compilers will aggressively stack-allocate objects
that they observe to be or are declared to be immutable. This enables JavaScript
code accessing points stored as two-element arrays to be reasonably efficient.
Julia’s JIT compiler is especially aggressive at stack-allocating almost all
immutable objects. This does not change the semantics from the user’s
perspective; it is merely an optimization made by the compiler.

In summary, memory does not need to be actually shared by a particular
implementation for a language to have call-by-sharing semantics.

## Closing Remarks

I hope this blog post has cleared up some of the confusion regarding
call-by-value and call-by-reference, and how call-by-sharing—a relatively
unknown term—is indeed more precise and accurate for many languages.

[evaluation strategies]: https://en.wikipedia.org/wiki/Evaluation_strategy
[Ruby is not call-by-reference]: http://stackoverflow.com/questions/1872110/is-ruby-pass-by-reference-or-by-value
