class Student
    attr_accessor :first_name, :last_name ,:email, :username
    
    @first_name
    @last_name
    @email
    @username

    def to_s
        "First Name:#{@first_name}"
    end
end
testobj=Student.new
testobj.first_name("vishakha")
testobj.last_name("nimbalkar")
testobj.email("test@test.com")
testobj.username("vishakhan")
p testobj