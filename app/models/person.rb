class Person < ActiveRecord::Base
  validates :email, :presence => true, :email => true
  validates :phone_number, :phone => true
  validates :first_name, :last_name, :address, :presence => true
end
