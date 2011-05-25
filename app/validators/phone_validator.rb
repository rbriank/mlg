# To change this template, choose Tools | Templates
# and open the template in the editor.

class PhoneValidator < ActiveModel::EachValidator
  def validate_each(record,attribute,value)
    begin
      digit_count = value.scan(/[0-9]/).size
      valid_chars = (value =~ /^[+\/\-() 0-9]+$/)
      valid_phone = (digit_count > 6 && valid_chars)

    rescue Exception => e
      valid_phone = false

    end
    record.errors[attribute] << (options[:message] ||
        "is invalid, must contain at least 7 digits, and only: 0-9/-()+") unless valid_phone
  end
end