a=[1,2,3,4,5,6,7,8,9]

p a.last;
#range is in number
x=1..100
#x is just range
p x;
#check class of x it should be range
p x.class
p x.to_a
p x.to_a.shuffle
#Now range is string 
y="a".."z"
p y
p y.to_a
p y.to_a.length

p a.unshift("veersen")
p a.unshift("veersen")
p a.append("Vishwajeet")
p a.include?("Vishwajeet")
p a.uniq;
a.to_a.each do |t|
    p t 
end    