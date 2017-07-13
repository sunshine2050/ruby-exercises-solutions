puts lambda{}
puts Proc.new {}

#A block created with lambda behaves like a method when you use return and simply exits the block, handing control back to the calling method.

def a_method
    lambda { return "we just returned from the block lambda" }.call
    return "we just returned from the calling method lambda"
end

puts a_method

#######################

#A block created with Proc.new behaves like it’s part of the calling method when return is used within it, and returns from both the block itself as well as the calling method.

def b_method
    Proc.new { return "we just returned from the block Proc" }.call
    return "we just returned from the calling method Proc"
end

puts b_method

#######################

# this method here accepts a block
def block_test
    puts "in block"
    yield
end

block_test{puts "I'm passing this to block_test"}

#######################

#yielding with parameters
def block_test_params(p)
    puts p
    puts "in block params"
    yield("abc")
end

#name takes value "abc"
#I'm calling the method, passing a parameter and a block.
block_test_params('hello'){|name| puts "over here name is #{name}"}

#######################

#blocks can't be saved since they are not objects.
#Procs can be saved!
multiples_of_3 = Proc.new do |n|
    n % 3 == 0
end

#instead of writing it: a=(1..100).to_a.select{|n| n%3==0}
#The & is used to convert the proc into a block since select accepts a block.
a=(1..100).to_a.select(&multiples_of_3)
p a.inspect

#######################
#Here we create a method, a Proc, then call the method while passing the new proc.
# proc is the same as Proc.new
# just as ->(a, b) { a + b } is the same as lambda{|a,b| a+b}

def greeter
    yield
end

phrase= proc{puts "Hello there!"}
greeter(&phrase)

# if we were passing a normal block, then we would do this
# greeter{puts "Hello there!"}
# note that this is not a paramter (greeter takes no params)

###########################

#Procs can be called directly

hi = Proc.new{puts "Hello!"}
hi.call

###########################

#symbols can be used to reference method names.
#We can pass a normal ruby method (symbol) as a proc, by adding &

numbers_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

#applying to_s on each element of the numbers_array
strings_array = numbers_array.collect(&:to_s)


###########################

#lambdas are almost identical to Procs. They are also objects

def lambda_demo(a_lambda)
    puts "I'm the method!"
    a_lambda.call #just like calling a proc
end

#note here we're not passing it as a block but as a parameter, and calling it inside the method.
lambda_demo(lambda { puts "I'm the lambda!" })

############################

#using lambda to convert an array of strings to an array of symbols.

strings = ["leonardo", "donatello", "raphael", "michaelangelo"]

symbolize = lambda {|n| n.to_sym}

symbols = strings.collect(&symbolize)

############################


#differences between lambda and proc. 1- params count matters in lambda, 2- when lambda returns it goes back to calling function, when Proc returns, it leaves everything.

def batman_ironman_proc
    victor = Proc.new { return "Batman will win!" }
    victor.call
    "Iron Man will win!"
end

puts batman_ironman_proc

def batman_ironman_lambda
    victor = lambda { return "Batman will win!" }
    victor.call
    "Iron Man will win!"
end

puts batman_ironman_lambda

#output: Batman will win!  #proc returns this and leaves
#        Iron Man will win! #lambda goes back to calling fn and prints returns last statement which is Iron Man will win!

############################

#use lambda to return elements that are symbols only

my_array = ["raindrops", :kettles, "whiskers", :mittens, :packages]

symbol_filter = lambda{|v| v.is_a? Symbol}

symbols = my_array.select(&symbol_filter)

############################

#All this talk of blocks, procs, and lambdas might have your head spinning. Let's take a minute to clarify exactly what each one is:

#A block is just a bit of code between do..end or {}. It's not an object on its own, but it can be passed to methods like .each or .select.

#A proc is a saved block we can use over and over.

#A lambda is just like a proc, only it cares about the number of arguments it gets and it returns to its calling method rather than returning immediately.

############################

# how to mixin / use the idea of open classes, to create a custom select enumerable method. As you can see it can be called with a block even though it takes no arguments. The block is not an argument, its called using yield. If passed as an argument, will need to call it, x.call

module Enumerable
    def select2
        r=[]
        self.each do |item|
            if yield(item)
                 r<<item
            end
        end
        return r
    end
end

less_than_2= Proc.new{|f| f<=2}

p [1,2,3,4].select2(&less_than_2)

###########################

#lambda can be used in rails as follows:
class Person < ActiveRecord::Base
    scope :find_lazy, lambda {|id| where(:id => id)}
end

# In console I can call
Person.find_lazy(1)
# called on class, not on instance of it. if instance, then make a normal method.

#so you're passing a block to find_lazy, which accepts one parameter which is the id. if Person.find_lazy(1,2) then lambda will be {|a,b| .. } i believe.

###########################





