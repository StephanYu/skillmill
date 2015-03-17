class Project < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end
