class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
		array = self.username.split(" ")
		new_array = array.join("-").downcase
		new_array
	end

 

end
