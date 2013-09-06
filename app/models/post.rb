class Post < ActiveRecord::Base
  include ActiveModel::Validations

  validates_presence_of :title

end
