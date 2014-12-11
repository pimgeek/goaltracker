class Topic

  include Mongoid::Document
  include Mongoid::Timestamps

  field :title1,             type: String
  field :title2,             type: String
  field :title3,             type: String
  field :title4,             type: String


  
  belongs_to :user

  validates :title1, :presence => true


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