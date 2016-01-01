class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name,:birthday,:major,:occupation,:school,:former_occupation
  has_many :topics
  has_many :drafts
  has_many :comments

  has_many :likes
  has_many :like_topics,:through=>:likes,:source=>:topic
  has_many :subscriptions
  has_many :subscription_topics,:through=>:subscriptions,:through=>:topic

end
