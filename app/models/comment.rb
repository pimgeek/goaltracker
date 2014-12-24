class Comment

  include Mongoid::Document
  include Mongoid::Timestamps

  field :content,             type: String

  
  belongs_to :user
  belongs_to :topic

  validates :user, :content, :topic, :presence => true


  default_scope -> { order('id asc') }



  module UserMethods
    def self.included(base)
      base.has_many :comments
    end
  end



  include Notice::CommentMethods



end