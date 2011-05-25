# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :person do |f|
  f.first_name "MyString"
  f.last_name "MyString"
  f.address "MyString"
  f.phone_number 1
  f.email "MyString"
  f.verified false
end