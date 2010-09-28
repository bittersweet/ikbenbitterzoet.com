---
layout: post
title: Using responders to clean up your controllers
---

Rails 3 ships with a feature called [Responders][], you might be already using
it to render different formats in your controllers. In this article I'll be
talking about the [Responders gem][] by José Valim that spawned this feature.
It really allows you to dry up your controllers and remove boilerplate code.

[Responders]: http://railsapi.com/doc/rails-v3.0.0/classes/ActionController/Responder.html
[Responders gem]: http://github.com/plataformatec/responders

This should look familiar:

{% highlight ruby %}
def create
  @asset = Asset.new(params[:asset])
  if @asset.save
    redirect_to(@asset, :notice => 'Asset was successfully created.')
  else
    render :action => "new"
  end
end
{% endhighlight %}

We can use the Responder gem by José to refactor this and DRY it up a bit. It
comes packed with a few responders to help you on your way, the ones I'm
interested in are the [flash][] and [collection][] responders.

[flash]: http://github.com/plataformatec/responders/blob/master/lib/responders/flash_responder.rb
[collection]: http://github.com/plataformatec/responders/blob/master/lib/responders/collection_responder.rb

The flash responder helps you with setting flash messages, what's great about
it is that it allows you to define them in a very DRY-like manner via a locale
file that your controller will use to generate the flash message.

The default looks like this and almost suits my needs perfectly, I like to
change `destroy` into `deleted`.

{% highlight yaml %}
 flash:
    actions:
      create:
        notice: "%{resource_name} was successfully created."
      update:
        notice: "%{resource_name} was successfully updated."
      destroy:
        notice: "%{resource_name} was successfully destroyed."
        alert: "%{resource_name} could not be destroyed."
{% endhighlight %}

The collection responder makes sure that __create__ and __update__ actions
will redirect to the collection rather then the resource itself. I like this
behaviour for Admin controllers, where I just want to create a resource and
continue instead of being redirected to the resource in question.

A related sidenote: José was very approachable when I wanted to make a custom
responder that took care of the redirecting I was talking about, and whipped
one up for me in no time to do just that. I'm glad to see it now comes packaged
with the gem itself! So this taught me not to be afraid to ask a gem author for
help, my specific situation proved to be usefull for others as well.

### Using the Responders gem

Add `gem 'responders'` to your gemfile and run `bundle install`. That should
take care of installing the gem and now we can use the builtin modules it
provides.

`lib` is the preffered location for defining a responder so create a file
called `lib/app_responder.rb` and include the necessary modules.

{% highlight ruby %}
 class AppResponder < ActionController::Responder
    include Responders::FlashResponder
    include Responders::CollectionCacheResponder
  end
{% endhighlight %}

Let's take a look at how we can refactor our controller action now, what a
difference! Our responder takes care of setting the flash and redirecting.

{% highlight ruby %}
def create
  @asset = Asset.new(params[:asset])
  @asset.save
  respond_with(@asset)
end
{% endhighlight %}

All that's left now is configuring our application to actually use our
responder.  Include the following into your `application_controller.rb` and you
should be all set.

{% highlight ruby %}
class ApplicationController < ActionController::Base
  self.responder = AppResponder
  respond_to :html
end
{% endhighlight %}

All in all I'd say it's a pretty good improvement, and I'll continue to use
this gem to keep my controllers clean without having to repeat the same
boilerplate code everytime.

You could also try the [inherited_resouces][] gem (again written by José, does
this guy ever sleep?) but that's a bit to much abstraction for my taste.

[inherited_resouces]: http://github.com/Josévalim/inherited_resources
