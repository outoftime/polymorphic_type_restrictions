class Photo < ActiveRecord::Base
  belongs_to :attached, :polymorphic => true

  # This is here to ensure that classes can explicitly define *_type= methods
  # as they would expect.
  def attached_type=(attached_type)
    write_attribute(:attached_type, attached_type)
  end
end
