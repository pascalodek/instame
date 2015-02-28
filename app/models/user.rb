class User < ActiveRecord::Base
	has_many :photos
	has_many :comments

	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :login, :presence => true
	validates :password, :presence => true
	validates :password_confirmation, :presence => true
	validates_uniqueness_of :login
	validates_confirmation_of :password

	def password
        @password
  	end

	def password_valid?(input)
		return self.password_digest == Digest::SHA1.hexdigest(input + self.salt)
	end

  	def password=(p_word)
		@password = p_word
		self.salt = rand().to_s
  		self.password_digest = Digest::SHA1.hexdigest(p_word + self.salt)
  		
	end

	def password_validate
		if @password_confirmation != @password then
			errors.add(:password, "Incorrect password")
		end
	end

validate :password_validate
end
