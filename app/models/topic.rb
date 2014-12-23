class Topic

  include Mongoid::Document
  include Mongoid::Timestamps

  field :content,             type: String

  
  belongs_to :user

  validates :content, :user, :presence => true


  default_scope -> { order('id asc') }



  def owner?(other_user)
    user == other_user
  end


  module UserMethods
    def self.included(base)
      base.has_many :topics
    end
  end



end