class UserInformation < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  # MENTORING_KINDS = [''] for the future as checkboxes
end
