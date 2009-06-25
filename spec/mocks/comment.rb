class Comment < ActiveRecord::Base
  belongs_to :commentable,
             :polymorphic => true,
             :allow => 'Commentable'

  # This is here to ensure that classes can explicitly define *_type= methods
  # as they would expect.
  def commentable_type=(commentable_type)
    write_attribute(:commentable_type, commentable_type)
  end
end
