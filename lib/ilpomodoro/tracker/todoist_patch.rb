require 'todoist'

# Patching Todoist gem 
# 

module Todoist
  class Base
    class AuthenticationError < StandardError; end 

    ##
    # Get authentication token using user email and password, 
    # set up this token for making requests (see #setup method)
    def self.login(email, password)
      response = HTTParty.post('https://todoist.com/API/login', {body: {email: email, password: password}})
      if response.body == "\"LOGIN_ERROR\""
        raise Todoist::Base::AuthenticationError, "Wrong passowrd of email. You entered #{email} as email."
      else
        self.setup(response['token'], response['is_premium'])
      end
    end

  end
end


module Todoist

  class Note

    ATTRIBUTES = [:is_deleted, :is_archived, :content, :posted_uid, 
                  :item_id, :uids_to_notify, :id, :posted, :task]

    attr_accessor *ATTRIBUTES

    def initialize(hash = {})
      ATTRIBUTES.each do |attribute|
        self.public_send("#{attribute}=", hash.fetch(attribute.to_s))
      end
    end

    def deleted?
      self.is_deleted == 0
    end

    def archived?
      self.is_archived == 0
    end

  end
end


module Todoist

  class Task

    def add_note(content)
      query = {item_id: id, content: content}
      Todoist::Base.post('/addNote', :query => query)
    end

    def notes
      response = Base.get('/getNotes', :query => {item_id: id})
      response.map { |n| Todoist::Note.new(n.merge!('task' => self)) }
    end

  end
end
