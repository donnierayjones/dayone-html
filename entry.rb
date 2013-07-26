require 'plist'

class Entry
  def self.from_path(path_to_doentry, path_to_photo)
    return Entry.new Plist::parse_xml(path_to_doentry), path_to_photo
  end

  def initialize(plist, path_to_photo)
    @plist = plist
    @path_to_photo = path_to_photo
  end

  def id
    @plist['UUID']
  end

  def text
    @plist['Entry Text']
  end

  def date
    @plist['Creation Date']
  end

  def tags
    if @plist['Tags']
      return Array.new @plist['Tags']
    end
    []
  end

  def has_photo
    File.exist? @path_to_photo
  end

  def photo_content_type
    'image/jpeg'
  end

  def photo_data
    File.read(@path_to_photo)
  end
end
