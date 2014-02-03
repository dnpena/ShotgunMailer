class Email < ActiveRecord::Base

	belongs_to :user
	belongs_to :conversation

	before_save :start_conversation

	def start_conversation
		if self.conversation_id==nil
			c = Conversation.create({subject: self.stripped_subject})
	    	self.conversation_id = c.id
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
		r += "<blockquote type=\"cite\" class=\"clean_bq\">"
		r = r+body_html+"</blockquote>"
		return r
	end

	def stripped_subject
		new_sub = self.subject.to_s.strip #'Re: asdf asdf asdf asd'
		to_search = new_sub.index('Re: ')==0 ? new_sub[4..-1] : new_sub
		#Email.where('lower(subject) like ?', '%'+to_search+'%')
		return to_search
	end
end
