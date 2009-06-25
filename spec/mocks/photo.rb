class Photo < ActiveRecord::Base
  belongs_to :attached, :polymorphic => true
end
