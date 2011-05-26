class Person < ActiveRecord::Base
  validates :email, :email => true, :allow_blank => true
  validates :phone_number, :phone => true, :allow_blank => true
  validates :first_name, :last_name, :address, :email, :presence => true

  scope :named, lambda {|name|
    where("first_name = ? OR last_name = ?", name, name)
  }

  def verify
    update_attribute(:verified, true)
  end
end
