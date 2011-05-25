class Person < ActiveRecord::Base
  validates :email, :presence => true, :email => true
  validates :phone_number, :phone => true, :allow_blank => true
  validates :first_name, :last_name, :address, :presence => true

  def verify
    update_attribute(:verified, true)
  end
end
