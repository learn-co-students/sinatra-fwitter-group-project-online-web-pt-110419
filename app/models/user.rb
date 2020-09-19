class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
		self.username.downcase.gsub(/\s+/m,' ').strip.split(" ").join("-")
	end

  def self.find_by_slug(slug)
    self.find_by("username LIKE ?", slug.split("-").join(" "))
  end

end
