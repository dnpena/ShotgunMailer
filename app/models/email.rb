class Email < ActiveRecord::Base

	belongs_to :user
	belongs_to :conversation

	before_save :start_conversation

	def start_conversation
		if self.conversation_id==nil
			c = Conversation.create({subject: self.stripped_subject})
	    	self.conversation_id = c.id
	    	if self.user_id!=nil #an email being sent
	    		c.update_attribute(:read, true)
	    		c.update_attribute(:archived, true)
	    	end
	    end
	end
	
	def get_body
		body_html = ''
		begin
			body = self.body_html.index('<body')
			body_tag_end = self.body_html.index('>',body)+1
			body_end = self.body_html.index('</body>')-1
			body_html = self.body_html[body_tag_end.to_i..body_end.to_i]
		rescue
			if self.body_html==nil
				return ''
			else
				body_html = self.body_html.to_s
			end
		end
		r = ""
		r += '<div class="gmail_extra">'
		r += "<br><br>"
		r += '<div class="gmail_quote">'
		r += "#{self.created_at.strftime('%Y-%m-%d %H:%M:%S %p')} #{self.sender}:"
		r += "<br>"
		r += '<blockquote class="gmail_quote" style="margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex" >'
		r = r+body_html
		r += "</blockquote>"
		r += "</div>"
		r += "</div>"
		return r
	end

	def stripped_subject
		new_sub = self.subject.to_s.strip
		to_search = new_sub.index('Re: ')==0 ? new_sub[4..-1] : new_sub
		return to_search
	end
	def find_conversation
		to_search = self.stripped_subject
		c = Conversation.order('updated_at desc').where('subject = ?', to_search).first
		#TODO prevent nesting with standard subjects
		email = self.sender
		if c && (c.emails.map{|e| e.sender}+c.emails.map{|e| e.recipient}).select{|e| e==email}.empty?()
			c = nil
		end
		return c ? c.id : nil
	end

end
