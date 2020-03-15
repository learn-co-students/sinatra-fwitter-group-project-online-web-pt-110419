class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
		array = self.username.split(" ")
		new_array = array.join("-").downcase
		new_array
	end

  def self.find_by_slug(slug)
    new_array = []
    array = slug.split("-")
    array.each do |word|
    new_array << word
    end
    final = new_array.join(" ")
    self.find_by("username like ?", final)
  end

end
