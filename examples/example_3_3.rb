# A block is a closure; it remembers the context in which it was defined, and it uses
# that context whenever it is called. The context includes the value of self, the
# constants, the class variables, the local variables, and any captured block.

# In the example below. When we call the block the first time, change the values
# of the class variable, class instance variable and instance variable, then
# call the block again. You'll see that the result changes, since the block is
# aware of the scope it is in.

class BlockExample
  
  class << self
    attr_accessor :class_instance_variable
  end
  
  CONST=0
  @@class_variable = 4
  @class_instance_variable = 5
  
  def return_closure
    local_variable=1
    @instance_variable=2
    lambda {[CONST,@@class_variable, @instance_variable, BlockExample.class_instance_variable, local_variable, yield]}
  end
  
  def change_values
    @@class_variable += 1
    BlockExample.class_instance_variable+=1
    @instance_variable+=1
  end
  
end


eg = BlockExample.new
block= eg.return_closure{"original"}

p block.call
eg.change_values
p block.call

