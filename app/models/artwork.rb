class Artwork < ActiveRecord::Base

  attr_accessor :ids, :collaborator_ids

  belongs_to :user
  belongs_to :series
  alias_attribute :creator, :user

  has_many :feed_items, dependent: :destroy
  has_many :artwork_collaborators
  has_many :collaborators, through: :artwork_collaborators, source: :collaborator
  has_many :approved_collaborators, -> { where artwork_collaborators: { status: 1 } }, through: :artwork_collaborators, source: :collaborator
  has_many :pending_collaborators, -> { where artwork_collaborators: { status: 0 } }, through: :artwork_collaborators, source: :collaborator
  has_many :documents, dependent: :destroy

  scope :unassorted, -> { where(series_id: nil) }

  validates :image_url, presence: true

  validates :month, :year, :length, :width, :height, :unit, :title, presence: true, on: :series_save
  validate :atleast_one_media?, on: :series_save
  validate :atleast_one_subject?, on: :series_save

  validates :month, :year, :length, :width, :height, :unit, :title, presence: true, on: :update
  validate :atleast_one_media?, on: :update
  validate :atleast_one_subject?, on: :update

  validates :month, :year, :length, :width, :height, :unit, :title, presence: true, on: :create
  validate :atleast_one_media?, on: :create
  validate :atleast_one_subject?, on: :create

  enum unit: %w(cm inch foot)

  def media
    Medium.approved.where(id: medium_ids).pluck(:name)
  end

  def subjects
    Subject.approved.where(id: subject_ids).pluck(:name)
  end

  private

  def atleast_one_media?
    errors.add('Medium: ', 'Atleast one should be present') if medium_ids.blank?
  end

  def atleast_one_subject?
    errors.add('Subject/Theme: ', 'Atleast one should be present') if subject_ids.blank?
  end

end
