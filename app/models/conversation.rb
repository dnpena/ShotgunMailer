class Conversation < ActiveRecord::Base

	has_many :emails, conditions: { spam: false }, order: 'updated_at asc'


	def get_senders
		#TODO not add only one, but all participants of the conversation hopefully with no email
		received = self.emails.select{|e| e.user_id==nil}.first
		receiver = received ? received.sender : ''
		sent = self.emails.select{|e| e.user_id!=nil}.first
		sender = sent ? (received ? ', ' : '')+sent.sender : ''
		return receiver+sender
	end

	def get_counter
		return ' ('+self.emails.length.to_s+')'
	end

	def destroy
		self.update_attribute :deleted, true
		self.emails.update_all deleted: true
	end
end
