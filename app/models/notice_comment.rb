class NoticeComment

  include Mongoid::Document
  include Mongoid::Timestamps

  field :content,             type: String

  
  belongs_to :user
  belongs_to :topic

  validates :user, :content, :topic, :presence => true


  default_scope -> { order('id asc') }



  module NoticeMethods
    def self.included(base)
      base.has_many :notice_comments
    end
  end

  module UserMethods
    def self.included(base)
      base.has_many :notice_comments
    end
  end



end