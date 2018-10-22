class Author

  attr_accessor :name

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
    story.author = self unless story.author == self
  end

  def bibliography
    #better syntax to use stories instance method (self.stories) instead of @stories
    self.stories.collect {|s| s.name}
  end

  def categories # has_many categories through stories
    self.stories.collect {|s| s.category}.uniq
  end

end
