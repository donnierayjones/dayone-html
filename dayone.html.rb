require 'rubygems'
require 'sinatra'
require 'sinatra/config_file'
require 'haml'
require 'sass'
require 'plist'
require 'redcarpet'
require './entry.rb'

class DayOneHtml < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  def initialize()
    super
    @entries_path = ENV["HOME"] + "/Dropbox/Apps/Day One/Journal.dayone/entries/"
  end

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
    entry = Entry.from_path(@entries_path + id + '.doentry', @entries_path + '../photos/' + id + '.jpg')
    redirect 404 unless entry.has_photo

    cache_control :public, max_age: 60
    content_type entry.photo_content_type
    entry.photo_data
  end

  get '/:style.css' do |style|
    content_type 'text/css', :charset => 'utf-8'
    scss style.to_sym
  end

  def get_entries()
    @entries = []
    Dir.glob(@entries_path + '*.doentry') do |entry_path|
      photo_path = entry_path.sub('entries', 'photos').sub('.doentry', '.jpg')
      entry = Entry.from_path(entry_path, photo_path)
      if entry.date >= settings.startDate and entry.date <= settings.endDate
        @entries << Entry.from_path(entry_path, photo_path)
      end
    end

    @entries.sort_by! do |e|
      e.date
    end
  end

  def get_markdown()
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true)
  end
end

DayOneHtml.run!
