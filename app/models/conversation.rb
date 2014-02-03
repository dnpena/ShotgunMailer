class Conversation < ActiveRecord::Base
	has_many :emails, order: 'updated_at asc'


	def get_senders
		received = self.emails.select{|e| e.user_id==nil}.first
		receiver = received ? received.sender : ''
		sent = self.emails.select{|e| e.user_id!=nil}.first
		sender = sent ? (received ? ', ' : '')+sent.sender : ''
		return receiver+sender
	end
	def get_counter
		return ' ('+self.emails.length.to_s+')'
	end
end
