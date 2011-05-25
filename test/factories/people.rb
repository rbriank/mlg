# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :person do |f|
  f.first_name "MyString"
  f.last_name "MyString"
  f.address "MyString"
  f.phone_number "993-993-4567"
  f.email "me@mine.com"
  f.verified false
end