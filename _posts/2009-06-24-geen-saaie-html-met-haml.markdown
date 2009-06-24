---
layout: post
title: Geen saaie HTML met Haml
intro: Gebruik Haml om de saaiheid van het schrijven van HTML weg te nemen.
---

# {{ page.title }}

Het schrijven van HTML kan een saaie aangelegenheid zijn, zelfs met een goede editor die veel werk kan wegnemen. Daarom kan je gebruik maken van [Haml](http://Haml.hamptoncatlin.com/), om het weer leuk te maken.

Haml heeft een aantal voordelen, zo is het gebaseerd op indentatie, zodat je gepushed wordt om een goede structuur te geven aan je pagina. Hierdoor hoef je ook geen closing tags meer te gebruiken omdat Haml hierdoor kan achterhalen wanneer een tag gesloten moet worden.

Het toont ook veel overeenkomsten met CSS, wat verschillende voordelen met zich meebrengt. Zo kan je dezelfde notatie blijven gebruiken, als # en . voor id's en classes. Hiernaast kan je de markup die je hebt gebruikt zo omzetten in goede CSS als je ook gebruik maakt van SASS, wat ik zal behandelen in een latere post.

### Installatie en gebruik

Haml is een Ruby Gem die je als volgt installeert:

{% highlight sh %}

$ sudo gem install Haml
{% endhighlight %}

Als je dat hebt gedaan ben je al up and running! Haml wordt voornamelijk gebruikt met Ruby on Rails waar het ge&iuml;ntegreerd kan worden -- zodat je er geen omkijken meer naar hebt -- maar het is ook los te gebruiken.

Maak een bestand aan met de extensie .Haml en voer vervolgens het volgende uit op de commandline om een HTML pagina te genereren.

{% highlight sh %}

Haml index.haml index.html

{% endhighlight %}

### Voordelen

Om de voordelen van Haml uit te leggen zal ik het vergelijken met een HTML document. Neem een kijkje naar de basic opmaak van een pagina:

{% highlight html %}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
  <title>Dit is html</title>
  <link rel="stylesheet" href="screen.css" type="text/css"></link>
</head>
<body>
  
  <div id="wrapper" class="grid">
    
    <h1>Titel</h1>
    <p>Dit is een paragraaf</p>
    
  </div>
  
</body>
</html>

{% endhighlight %}

Om hetzelfde met Haml te bereiken doe je als volgt:

{% highlight html %}
!!! Strict
%html
  %head
    %title Dit is Haml
    %link{:rel => "stylesheet", :href => "screen.css", :type => "text/css"}
  %body
    #wrapper.grid
      %h1 Titel
      %p Dit is een paragraaf

{% endhighlight %}

Je ziet dus dat je kan indenteren om aan te geven dat die elementen kinderen zijn. Let hierbij op dat Haml gebruik maakt van **twee spaties**, dus **geen tabs**!

Om snel wat pagina's over te zetten om een voorbeeld te krijgen hoe Haml je markup kan verbeteren, kan je gebruik maken van het meegeleverde `html2Haml`.

{% highlight sh %}

html2Haml index.html index.haml

{% endhighlight %}

### Leesvoer

* [Haml tutorial](http://haml.hamptoncatlin.com/tutorial)
* [Haml reference](http://haml.hamptoncatlin.com/docs/rdoc/classes/Haml.html)
* [Haml op de Rails wiki](http://wiki.rubyonrails.org/howtos/templates/haml)
