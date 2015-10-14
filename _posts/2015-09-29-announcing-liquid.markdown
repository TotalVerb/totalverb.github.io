---
layout: post
title:  "Announcing Liquid"
date:   2015-09-29 5:01:29
categories: liq
---
I finally released one of the projects I'm working on, [liquid].
It's a simple game played by two people. The goal is to be the last
person to have a legal move.

Legal moves are ones that fill either an empty square or a square you
control with your colour of water. If a square overflows, the weakest
wall around it will break down and the water in the adjacent cell will
become yours.

Currently the game is far from complete; for example, it still does not
check win or loss conditions, and the UI leaves much to be desired.

[liquid]: http://wafy.me/liquid
