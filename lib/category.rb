class Category

  attr_accessor :name
  attr_reader :stories

  def initialize
    @stories = [] # has_many interface
  end

  def stories # has_many stories interface
    @stories.dup.freeze #enforcing that stories can only be added using #add_song
    #in addition to NOT adding an attr_accessor for @stories
  end

  def add_story(story) #has_many interface
    raise AssociationTypeMismatchError, "#{story.class} received, Story expected" if !story.is_a?(Story)
    @stories << story
    story.category = self unless story.category == self
  end

  def authors # has_many authors through stories
    self.stories.collect {|s| s.author}.uniq
  end

end
