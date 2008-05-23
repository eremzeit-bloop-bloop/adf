>> %w( active_support active_record active_record/validations ).each { |lib| require lib }
=> ["active_support", "active_record", "active_record/validations"]
>> module ActiveRecord::ValidationBase
>>   attr_accessor :errors
>>   def initialize options = {}
>>     @errors = ActiveRecord::Errors.new self
>>     end
>>   %w( save save! new_record? update_attribute ).each{|m| eval "def #{m}; end" }
>>   include ActiveRecord::Validations
>>   end
=> ActiveRecord::ValidationBase
>> class Dog
>>   attr_accessor :name
>>   end
=> nil
>> Dog.new.valid?
NoMethodError: undefined method `valid?' for #<Dog:0xb75bba8c>
        from (irb):13
>> class Dog
>>   include ActiveRecord::ValidationBase
>>   end
=> Dog
>> Dog.new.valid?
=> true
>> class Dog
>>   validates_presence_of :name
>>   end
NoMethodError: undefined method `validates_presence_of' for Dog:Class
        from (irb):19
>> Dog.new.save
=> nil
>> Dog.new.save!
=> nil
>> Dog.new.valid
NoMethodError: undefined method `valid' for #<Dog:0xb75a375c>
        from (irb):23
>> Dog.new.valid?
=> true
>> class Dog
>>   include ActiveRecord::Validations
>>   validates_presence_of :name
>>   end
=> [#<Proc:0xb77c4f68@/usr/lib/ruby/gems/1.8/gems/activerecord-2.0.2/lib/active_record/validations.rb:518>]
>> Dog.new.valid?
=> false
>> rover = Dog.new
=> #<Dog:0xb758a7fc @errors=#<ActiveRecord::Errors:0xb758a7c0 @errors={}, @base=#<Dog:0xb758a7fc ...>
>> rover.valid?
=> false
>> rover.name = 'rover'
=> "rover"
>> rover.valid?
=> true
>> 
