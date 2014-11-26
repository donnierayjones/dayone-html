# Quick and Dirty [Day One][1] HTML Export

I created this to export my Day One App entries into a format more
suited for printing to a book.

It runs on Ruby (Sinatra) and requires you store your posts in
Dropbox rather than iCloud.

It's not very flexible. You'll need to know your way around Ruby /
Sinatra to get it customized to your liking.

![screenshot](http://f.cl.ly/items/0d3N42390Z0f0g3p060M/Screen%20Shot%202014-03-22%20at%2011.25.58%20AM.png)

## Installation

### Prerequisites

* Install the latest version of Mac OS X (Yosemite). This includes
  Ruby v2 by default. (this may work on older versions, but I have
  not tested.)
* Open Terminal and run `sudo gem install bundler`
* [imagemagick][3] (use [homebrew][4] to install)

### Steps

Open Terminal and run the following commands:

1. `git clone https://github.com/donnierayjones/dayone-html.git`
2. `cd dayone-html`
3. `sudo bundle install`
4. `bundle exec ruby dayone.html.rb`

Now visit localhost:4567 to see your journal in HTML!

[1]: http://dayoneapp.com/
[2]: http://git-scm.com/downloads
[3]: http://www.imagemagick.org/script/binary-releases.php#macosx
[4]: http://brew.sh/
