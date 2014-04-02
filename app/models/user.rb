class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
end
