json.emails @emails do |email|
	json.id email.id
	json.sender email.sender
	json.subject email.subject
	json.content email.body_plain
	json.contenthtml email.body_html
	json.read email.read
end