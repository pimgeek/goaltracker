class Notice

  include Mongoid::Document
  include Mongoid::Timestamps

  
  belongs_to :user
  belongs_to :topicable, :polymorphic => true



  validates :topicable, :user, :presence => true


  default_scope -> { order('id desc') }


  def get_topicable_id
    case self.topicable.class.to_s
    when 'Comment'
      self.topicable.topic.id
    when 'Topic'
      self.topicable.id
    end
  end



  module UserMethods
    def self.included(base)
      base.has_many :notices


      base.send(:extend, ClassMethods)

    end

    module ClassMethods
      
    end
  end



  module TopicMethods

    def self.included(base)
      base.has_many :notices
    end
  end


  module CommentMethods
    
    def self.included(base)
      base.has_many :notices
    end
  end



end