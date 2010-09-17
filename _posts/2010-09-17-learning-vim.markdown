---
layout: post
title: learning vim
intro: A few tips to get good at using Vim
---

### Introduction

There's been an amazing response on HackerNews and the programming Reddit on 
the recent articles from [Jeff](http://jeffkreeftmeijer.com/2010/stumbling-into-vim/)
and [Vincent](http://nvie.com/posts/how-i-boosted-my-vim/), people were 
learning a lot from them so that motivated me to write my own version. My 
philosophy about Vim is that you never stop learning and reading about other 
people's experiences and tricks with Vim is the best way to learn.

A lot of the basic things were already covered by the previous mentioned
articles so I wanted to do it a bit differently. Instead of a just a list with
usefull commands I want to show you my way of thinking about Vim which will
hopefully make you a better Vim user.

### Recognize patterns

In my experience it doesn't take long before you can get up and running with 
Vim and be able to edit files. You're probably not as productive as you were 
before and keep grabbing that pesky mouse but don't worry, you took the first 
step. It's all a learning process from here. That is also one of the great 
things about choosing to 'learn' an editor, it's always great to look back and 
see how much you've learned!

One of the best tips I can give about using Vim efficiently is also applicable 
to other areas in programming and using a computer in general. __Learn to 
recognize patterns.__ In Vim there's almost __always__ a better and faster way 
to do things, with or without plugins.

For example, a novice Vim user will probably delete words by keep hitting the 
`x` key, this is a moment you need to stop and think about how you can do this 
better, or the _Vim way_.
Naturally you'll soon come across the `w` motion for words, and learn to combine
it with another motion to form `dw` to delete whole words.

Something I used to do was use visual line mode to select lines of code, or 
def/end blocks in Ruby to delete a whole method for example. That's when I 
looked around and learned about paragraphs. The def and end blocks in Ruby 
form a perfect example for this. Instead of going into visual mode and 
scrolling down or up to select a block you can use motion commands tied to 
paragraphs to do this faster and with less keystrokes.

Try using `vip` or `v}` at the beginning of a block to select it all in one go.

When writing this article I found myself reformatting a lot of stuff to fit in
a 80 columns layout by hand. One quick search later I now know you can use `gq`
to automatically reformat a block of text.

### Customize!

You can do a lot with a default build of Vim, but in my opinion if you take 
some time to customize your Vim a bit you will feel greater pleasure of working 
with it. There's something to be said for just using a default version, so you 
can find your way on whatever system you are, but in my case the customizations
aren't that severe that I can't work on a default setup at all, I would just be
a bit less efficient.

Based on my own experience I think it's good to warn people not to go overboard
with customizations and plugins, a person can only learn a couple of things a
day so just take it slow. Take lesson from the previous section and only go
looking for a plugin when you feel you're not doing something right, or that it
can be automated. I had a time where I was on the lookout for fresh plugins
everyday, instead of just working with what I had.

#### Favorite plugins

These are a couple of plugins I'm using that I can not do without, they each
gave me a huge boost to my productivity.

##### [Command-T][]

TextMate's open file window works great and as such has been 'copied' a lot, in
the beginning I was using fuzzyfinder_textmate but after finding Command-T I
will never go back. Because part of it is in C it's speed is amazing, even in a
large codebase you won't have to wait for searchresults. This tool is pretty
invaluable to me for being able to quickly navigate a project's codebase.

It's pretty smart as well as it has an weighting algorithm so you can get the
result you need with few keystrokes, so for example characters that follow a
path seperator will be weighted more. Take a look at the following, I only need
4 keystrokes ( `acat` ) to get the file that I want.

{% highlight bash %}
app/controllers/admin/tracks_controller.rb
{% endhighlight %}

For this plugin to work you need to have your Vim compiled
with Ruby support, depending on your Vim of choice (I use MacVim myself) a
recompile is probably necessary. For instructions on how to do this with
MacVim, the plugins creator has some information on his [wiki][]

[wiki]: https://wincent.com/wiki/Building_MacVim_from_source

##### [Ack.vim][]
Ack is an great replacement for grep and blazingly fast. It's pretty amazing
as you can give it a string and it will recursively find every occurance of it
in record speed, a great way to search your whole codebase. I use it if I'm not
quite sure where a certain piece of code is located or if I need to change a
certain string and want to make sure I've not forgotten any occurance.

The searchresults open in a quickfix window so you can use the standard `:cn`
(`:cnext`) or `:cp` (`:cprevious`) commands to navigate these quickly.

Check out `:h quickfix` for more of these commands.

##### [Rails.vim][]

I could be doing a lot more with this plugin as it featureset is just so
expansive.  I mostly use the navigation shortcuts like `R` to open the
corresponding file when my cursor is over a controller action for example. This
works with splits and tabs as well so just add `R` or `T` after it.

[command-t]: https://wincent.com/products/command-t
[ack.vim]: http://www.vim.org/scripts/script.php?script_id=2572
[rails.vim]: http://rails.vim.tpope.net/

### Read the help

If you're customizing your Vim you're probably using some plugins as well. In 
my first few months of using Vim I was just using them out of the box, not 
really tapping into their full potential. For example I was using NERDTree to 
open files. Because I love using different tabs for files I was always opening 
a new tab, toggling NERDTree again and find myself having to traverse the whole 
directory structure again. I was actually doing the same thing with Command-T. 

After a while I decided to read the help documentation for these plugins, which
was something I should have done a lot earlier! Turns out you can use `i` to
open in a split or `t` for a new tab from within the file list in NERDTree.
With this new knowledge I could navigate my projects a lot faster.

I also had a custom keybinding to refresh a projects files because NERDTree
doesn't automatically add new files to the file overview. A quick glance at the
help documentation and I learned to use `r` and `R` to recursively refresh the
current directory or the current root.

All the plugins you are using probably work fine but if you take the effort of 
going through the help files I will bet there's loads of functionality you 
weren't aware of yet!

##### Pathogen
If you're using [Pathogen][] to bundle all your plugins into one directory, you
can use the following command to generate all plugins helpdocs.

[pathogen]: http://www.vim.org/scripts/script.php?script_id=2332

{% highlight vim %}
:call pathogen#helptags()
{% endhighlight %}

### Never stop learning

My final advice, and something I hope will have been read between the lines is
that you should never stop learning.  just today I started using [Lusty
Juggler][] because I was linked to a [screencast][] showing how to use it.
I've always been a window and tab user, but I'll try out buffers to see how I
like it.

[Lusty Juggler]: http://www.vim.org/scripts/script.php?script_id=2050
[screencast]: http://lococast.net/archives/185

If you're starting out with Vim you're probably learning a lot, and it can be a
lot to take in. Try learning about things you can put to use right away, I find
that using it often is one of the best ways to learn a new command.  I write a
lot of stuff down in a notebook and if I don't use it often I find myself going
back to look it up.
