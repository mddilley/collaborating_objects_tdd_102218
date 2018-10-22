describe Category do
  let(:category){Category.new.tap{|c| c.name = "Fiction"}}
  let(:story){Story.new.tap{|s| s.name = "The Old Man and the Sea"}}
  it 'has a name' do
    #Expectation
    expect(category.name).to eq("Fiction")
  end

  describe 'has many stories' do
    it 'has an empty array of stories when initialized' do
      expect(category.stories).to match_array([])
    end

    it 'returns a frozen copy of the stories array' do
      expect(category.stories).to be_frozen
    end
  end

  describe '#add_story' do
    it 'can add a story instance onto it' do

      category.add_story(story)

      expect(category.stories).to include(story)
    end


    it "reciprocates assigning this category as the story's category" do
      category.add_story(story)

      expect(story.category).to eq(category)
    end
    it 'only allow stories to be pushed onto it' do
      story = "The Old Man and the Sea"
      expect{category.add_story(story)}.to raise_error(AssociationTypeMismatchError)
    end
  end

  describe 'has many authors through stories' do
    it 'returns the colleciton of unique category instances based on the stories' do
      king = Author.new{|c| c.name = "Steven King"}
      crichton = Author.new{|c| c.name = "Michael Crichton"}

      story_1 = Story.new.tap{|s| s.name = "It"; s.author = king}
      story_2 = Story.new.tap{|s| s.name = "The Stand"; s.author = king}
      story_3 = Story.new.tap{|s| s.name = "Sphere"; s.author = crichton}

      category.add_story(story_1)
      category.add_story(story_2)
      category.add_story(story_3)

      expect(category.authors).to match_array([king, crichton])
    end
  end

end
