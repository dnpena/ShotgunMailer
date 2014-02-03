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
		r += "<br /><br /><br />"
		r += "On #{self.created_at.strftime('%B %-d, %Y at %H:%M:%S %p')}, #{self.sender} wrote:"
		r += "<blockquote type=\"cite\" class=\"clean_bq gmail_quote\" style=\"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex\" >"
		r = r+body_html+"</blockquote>"
		return r
	end

	def stripped_subject
		new_sub = self.subject.to_s.strip #'Re: asdf asdf asdf asd'
		to_search = new_sub.index('Re: ')==0 ? new_sub[4..-1] : new_sub
		return to_search
	end
	def find_conversation
		to_search = self.stripped_subject
		c = Conversation.order('updated_at desc').where('lower(subject) like ?', '%'+to_search+'%').first
		#TODO prevent nesting with standard subjects
		return c ? c.id : nil
	end

end
