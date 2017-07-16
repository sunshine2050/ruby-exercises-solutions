
# Mixing in modules
#[6] Create a method that returns today's date. Method name should be 'current_date'
# This method should be in a module called 'Generic'.
# Try mixing in this module into the Document class
# Now use this method to create another method that returns
# The tite of the document and today's date like below:
# "document_title 2014-06-22". This method should be called 'title_with_date'


#[7] we would like to add a function that replaces a word with another
# replace_word(old_word, new_word)

#Metaprogramming
#[8] instead of calling document.replace_word(old,new) we would like to be able to
# do something like this: document.replace_book('pen') where book is the old word
# and pen is the new word. This should work on any word (not just book).
# hint:  'method_missing'

require 'time'

module Generic
   def current_date
     time = Time.now.to_s
     time = DateTime.parse(time).strftime("%Y/%m/%d")
   end
   

end

class Document
    include Generic
    attr_accessor :author,:title,:content
    def initialize(h = {})
    	h.each {|k,v| instance_variable_set("@#{k}",v)}
    end
    
    def title_with_date
      @title + " " + current_date
    end
    
    def +(b)
      return Document.new(author: @author, title: @title , content: @content + " " + b) if b.class == String
      Document.new(author: @author, title: @title , content: @content + " " + b.content)
    
    end

   def replace_word(old_word,new_word)
   		@content.sub! old_word, new_word
   		Document.new(author: @author, title: @title, content: @content)
   end   

    def words
      @content.split(' ')
    end
    
    def each_word
      yield words
    end
    def method_missing(func,new_str)
      if(func[0..7]=="replace_") 
        self.replace_word(func[8..func.length],new_str)
      end 
    end
end
a=Document.new(:author => "someone", :title => "my book", :content => "this is the content of my book")
a.replace_book("Whatever")