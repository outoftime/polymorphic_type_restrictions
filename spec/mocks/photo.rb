class Photo < ActiveRecord::Base
  belongs_to :attached, :polymorphic => true

  def attached_type=(attached_type)
    write_attribute(:attached_type, attached_type)
  end
end
