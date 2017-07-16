#[4] Continue in the Document class.
# add a 'words' function that returns the content of the document in the form of
# an array of words.
# Example: if content is "some more content here" then the function should return
# ["some", "more", "content", "here"]

#[5] Read about blocks in ruby [also check the ruby examples provided]
# add a function each_word that loops on the words in the document - you must use
# blocks
# This function is called like this:
# document.each_word do |word|
#  puts word
# end


class Document
  
	attr_accessor :author,:title,:content
	def initialize(h = {})
		h.each {|k,v| instance_variable_set("@#{k}",v)}
	end

	def +(b)
	  return Document.new(author: @author, title: @title , content: @content + " " + b) if b.class == String
	  Document.new(author: @author, title: @title , content: @content + " " + b.content)

	end
	
	def words
	  @content.split(' ')
	end
	
	def each_word
	  yield words
	end
end

a=Document.new(:author => "someone", :title => "my book", :content => "this is the content of my book")
b=Document.new(:author => "someone", :title => "my book", :content => "and so is this.")

a.words
b.each_word { |word| puts word }