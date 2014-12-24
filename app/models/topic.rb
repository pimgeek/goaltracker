class Topic

  include Mongoid::Document
  include Mongoid::Timestamps

  field :content,             type: String

  
  belongs_to :user
  has_many :comments

  validates :content, :user, :presence => true


  default_scope -> { order('id desc') }



  def owner?(other_user)
    user == other_user
  end


  module UserMethods
    def self.included(base)
      base.has_many :topics


      base.send(:extend, ClassMethods)

    end

    module ClassMethods
      def get_noticers(current_user)
        return nil unless current_user
        
        User.where(:id.ne => current_user.id).to_a
      end
    end
  end



end