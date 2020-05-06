class Name
    attr_reader :title, :first_name, :middle_name, :last_name
  
    def initialize(title, first_name, middle_name, last_name)
    @title = title
    @first_name = first_name
    @middle_name = middle_name
    @last_name= last_name
    end
  
  end
    def first_name
    @first_name
    end
  
    def middle_name
    @middle_name
    end
  
    def last_name
    @last_name
  end
  
  
  name = Name.new("Mr.")
  puts name.title + " " +
       name.first_name + " " +
       name.middle_name + " " +
       name.last_name
