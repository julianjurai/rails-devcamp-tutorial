class Portfolio < ApplicationRecord
  include Placeholder

  has_many :technologies

  accepts_nested_attributes_for :technologies,  reject_if: lambda { |attrs| attrs['name'].blank? }


  validates_presence_of :title, :body, :main_image, :thumb_image

  #after Portfolio.new is called
  after_initialize :set_defaults

  #creating custom scopes

  def self.angular
    where(subtitle: "Angular")
  end

  def self.by_position
    order("position ASC")
  end

  # OR

  scope :ruby_on_rails, -> { where(subtitle: "Ruby on Rails") }


  def set_defaults
    self.main_image ||= Placeholder.image_generator(height:"600", width: "400")
    self.thumb_image ||= Placeholder.image_generator(height:"350", width: "200")
  end
end
