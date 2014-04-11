class Spam < ActiveRecord::Base

	# TODO: A good spam checker method can be made here
	def self.search_pattern(email)
		return Spam.find_by_email(email)
	end
end
