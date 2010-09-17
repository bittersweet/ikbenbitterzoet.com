---
layout: post
title: Using Hoptoad with Ruby 1.9.2
intro: How to get hoptoad_notifier to work in Ruby 1.9.2
---

The hoptoad_notifier gem is not updated to work with Ruby 1.9.2 yet, the
following error will occur:

{% highlight bash %} NoMethodError (private method `params_filters=` called for
#<HoptoadNotifier::Notice:0x000001041b0dc8>): {% endhighlight %}

As discussed in [this Lighthouse
ticket](http://help.hoptoadapp.com/discussions/problems/778-nomethoderror-params_filters),
they are still working on official 1.9.2 support, in the meantime, there are a
couple of forks to get you going. I'm using [this
version](http://github.com/rich/hoptoad_notifier) by Rich Cavanaugh that works
well.

I've forked that one myself and added a .gemspec for easy integration in a
Gemfile, just drop this in and you're on your way!

{% highlight ruby %} gem 'hoptoad_notifier', :git =>
'http://github.com/bittersweet/hoptoad_notifier' {% endhighlight %}
