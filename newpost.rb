require 'date'
require 'fileutils'

title = ARGV[0]
file_title = title.tr(" ", "-").downcase

time = DateTime::now()

file_date = time.strftime("%Y-%m-%d")
post_date = time.strftime("%B %d, %Y")

post = File.new("_posts/#{file_date}-#{file_title}.textile", "w+")
post.puts "---
layout: post
title: #{title}
intro: 
---

h1. {{ page.title }}

"
