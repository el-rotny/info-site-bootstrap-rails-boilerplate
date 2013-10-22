class Page < ActiveRecord::Base
  has_and_belongs_to_many :categories

  validates :title, presence: true, length: { minimum: 5 }

  mount_uploader :header_image, HeaderImageUploader

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  MERCURY_FIELDS = [:title, :body]

  def save_from_mercury(params)
    MERCURY_FIELDS.each do |field|
      if params && params[:content] && params[:content][field] && params[:content][field][:value]
        send "#{field}=", params[:content][field][:value]
      end
    end
    save!
  end

end
