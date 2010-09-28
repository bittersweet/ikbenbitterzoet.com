---
layout: post
title: Multiple file upload with PLupload
---

[Plupload][] is gathering steam lately and I had a need for a easy multiple file
upload solution so I gave it a go.  In this article I'll first get file uploads
up and running with Rails 3 and Carrierwave, all via Mongoid. You can skip to
the last part if you've already taken care of that though.

A small note, this is just a quick runthrough how to get up and running, it's
not the perfect and cleanest way to do fileuploads, as there is no gracefull
degredation for example. It's meant to give you a headstart, something for you
to get going on.

If you're already have file uploading working in your app you can skip over to
the Plupload section of this article, otherwise read on for a quick setup of
a fresh Rails 3 app with Mongoid and Carrierwave.

[plupload]: http://plupload.com/

### Mongoid and Carrierwave

First lets generate a new Rails 3 app, without Active Record and Prototype.

{% highlight bash %}
rails new plupload-example -OJ
{% endhighlight %}

Update the gemfile to include `mongoid`, `bson_ext`, `carrierwave` and
`mini_magick`. Don't forget to `bundle install` afterwards. I'm building
Carrierwave directly from Github as the latest gem isn't compatible with Rails
3 just yet.

{% highlight ruby %}
gem 'mongoid', '>= 2.0.0.beta.17'
gem 'bson_ext', '1.0.4'

gem 'carrierwave', :git => 'http://github.com/jnicklas/carrierwave.git'
gem 'mini_magick', :git => 'git://github.com/probablycorey/mini_magick.git'
{% endhighlight %}

We'll need a quick config file for mongoid so you can run the included
generator, the default settings are fine.

{% highlight bash %}
rails g mongoid:config
{% endhighlight %}

To get up and running quickly for this example I used scaffolding.

orm mongoid instellen en kijken of er wat veranderd

{% highlight bash %}
rails g scaffold Asset
{% endhighlight %}

You can add relevant keys etc in the Asset model but for this example it's not
necessary.

Carrierwave has it's own way of doing uploads if you compare it with Paperclip
for example, it defines an upload class in `app/uploaders`. I kind of like this
approach as the logic is extracted from the controller and looks cleaner to me.
Of course there is an associated generator for this:

{% highlight bash %}
rails g uploader Asset
{% endhighlight %}

Now we can mount this uploader in our model, so update it accordingly.

{% highlight ruby %}
class Asset
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :asset, AssetUploader
end
{% endhighlight %}

Take a look at the settings in `app/uploaders/asset.rb`, the defaults are of
course fine for now but you can really go all out with customizing this. In my
case I want to process images and thumbnails via MiniMagick, to set that up you
can use the following code:

{% highlight ruby %}
  include CarrierWave::MiniMagick

  version :thumb do
    process :resize_to_fill => [80,80]
  end
{% endhighlight %}

### Plupload

You will need jQuery and the latest version of [Plupload][]. It's pretty great
in that it has most browsers covered with lots of fallbacks, but in my case the
image uploading will be in a closed environment and using the latest browsers,
so I'm focussing on just using the html5 runtime for this example.

[plupload]: http://www.plupload.com/

After you've unpacked Plupload, copy `plupload.min.js` and `plupload.html5.js`
to your javascripts directory. and add them somewhere in your view.

As mentioned, the following doesn't feature gracefull degredation but it's what
I used to get it to work. What is most important is sending along your
authenticity token via the parameters.

Most of this is taken straight from the Plupload examples, and features an
indicator for upload progress.

{% highlight html %}

<div>
  <div id="filelist"></div>
  <br />
  <a id="pickfiles" href="#">[Select files]</a>
  <a id="uploadfiles" href="#">[Upload files]</a>
</div>

<script type="text/javascript">
$(function(){
  var uploader = new plupload.Uploader({
    runtimes : "html5",
    browse_button : 'pickfiles',
    max_file_size : '10mb',
    url : "/assets",
    multipart: true,
    multipart_params: {
     "authenticity_token" : '<%= form_authenticity_token %>'
    }
  });

  uploader.bind('FilesAdded', function(up, files) {
    $.each(files, function(i, file) {
      $('#filelist').append(
        '<div id="' + file.id + '">' +
        'File: ' + file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
        '</div>'
        );
      });
    });

  uploader.bind('UploadProgress', function(up, file) {
    $('#' + file.id + " b").html(file.percent + "%");
  });

  $('#uploadfiles').click(function(e) {
    uploader.start();
    e.preventDefault();
  });

  uploader.init();
});
</script>
{% endhighlight %}

Almost there! Rails is looking for a `asset` key in the params hash but
unfortunately plpuload puts the uploaded file in the `file` key. I haven't
found a way to change the default behaviour yet. A quick fix is to modify the
controller but obviously I'd love to be able to change it.

{% highlight ruby %}
def create
  @asset = Asset.new(:asset => params[:file])
  if @asset.save
    head 200
  else
    render :action => "new"
  end
end
{% endhighlight %}

All you need know is a quick image tag to display your images.

{% highlight ruby %}
<%= image_tag @asset.asset.url(:thumb) %>
{% endhighlight %}

So there you have it, a pretty barebones way of getting up and running with
Plupload. There is a lot of stuff you could add:

* an upload queue for managing files to be uploaded
* showing a preview if you're uploading images
* drag and drop files

To be honest I found the 'documentation' quite lacking but the examples are
alright. If you are going to use Plupload to do something a lot fancier then
this article you will have to dive in deep with the sourcecode and examples.

### Sourcecode

I've uploaded the example app I created while writing this article to this
[Github repo][]. The commits are ordered just like here, so you can read along
with those.

[Github repo]: http://github.com/bittersweet/plupload-example
