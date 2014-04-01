class Remark < ActiveRecord::Base
  validates_presence_of :name
  validates_format_of 	:email, with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  validates_presence_of :message
  validates_length_of 	:message, maximum: 1000

end