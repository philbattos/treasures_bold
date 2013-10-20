class User < ActiveRecord::Base
	include Tire::Model::Search
	include Tire::Model::Callbacks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true # is uniqueness automatically validated by Devise?
	# validates :password, presence: true
end
