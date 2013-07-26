require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'plist'
require 'redcarpet'
require './entry.rb'

get '/' do
  @markdown = get_markdown
  @entries = get_entries

  haml :dayone, :format => :html5
end

get '/tag/:tag' do |tag|
  @markdown = get_markdown
  @entries = get_entries.select do |entry|
    entry.tags.include? tag
  end

  haml :dayone, :format => :html5
end

get '/photo/:id.jpg' do |id|
  entry = Entry.from_path('../entries/' + id + '.doentry', '../photos/' + id + '.jpg')
  redirect 404 unless entry.has_photo

  content_type entry.photo_content_type
  entry.photo_data
end

get '/:style.css' do |style|
  content_type 'text/css', :charset => 'utf-8'
  scss style.to_sym
end

def get_entries()
  @entries = []
  Dir.glob('../entries/*.doentry') do |entry_path|
    # do work on files ending in .rb in the desired directory
    photo_path = entry_path.sub('entries', 'photos').sub('.doentry', '.jpg')
    @entries << Entry.from_path(entry_path, photo_path)
  end

  @entries.sort_by! do |e|
    e.date
  end.reverse!
end

def get_markdown()
  Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
end
