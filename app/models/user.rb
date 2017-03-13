class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :representative_ids

  has_one :profile

  has_many :authentications, dependent: :destroy

  has_many :companies, foreign_key: 'owner_id'

  has_many :company_memberships
  has_many :companies_with_pending_membership, -> { where company_memberships: { state: 0 } },
    through: :company_memberships, source: :company
  has_many :companies_with_approved_membership, -> { where company_memberships: { state: 1 } },
    through: :company_memberships, source: :company
  has_many :approved_membership_companies, through: :company_memberships, source: :company
  has_many :joined_companies, through: :company_memberships, source: :company

  has_many :artworks
  has_many :series
  has_many :educations
  has_many :awards
  has_many :bibliographies
  has_many :residencies
  has_many :experiences
  has_many :publications
  has_many :collections
  has_many :memberships
  has_many :participations
  has_many :exhibitions
  has_many :media_features

  belongs_to :referrer, class_name: 'User', counter_cache: :referrals_count
  has_many :referrals, class_name: 'User', foreign_key: :referrer_id

  has_many :connections
  has_many :passive_connections, class_name: 'Connection', foreign_key: 'friend_id'

  has_many :active_friends, -> { where connections: { status: 1 } }, through: :connections, source: :friend
  has_many :passive_friends, -> { where connections: { status: 1 } }, through: :passive_connections, source: :user

  has_many :pending_friends, -> { where connections: { status: 0 } }, through: :connections, source: :friend
  has_many :pending_passive_friends, -> { where connections: { status: 0 } }, through: :passive_connections, source: :user

  has_many :rejected_friends, -> { where connections: { status: 2 } }, through: :connections, source: :friend
  has_many :rejected_passive_friends, -> { where connections: { status: 2 } }, through: :passive_connections, source: :user

  has_many :artwork_collaborators
  has_many :collaborated_artworks, through: :artwork_collaborators, source: :artwork
  has_many :pending_collaborations, -> { where artwork_collaborators: { status: 0 } }, through: :artwork_collaborators, source: :artwork

  accepts_nested_attributes_for :educations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :bibliographies, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :awards, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :residencies, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :experiences, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :publications, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :collections, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :memberships, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :participations, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :exhibitions, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :profile, reject_if: :all_blank
  accepts_nested_attributes_for :media_features, reject_if: :all_blank, allow_destroy: true

  validates :email, :title, :first_name, :last_name, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, uniqueness: true
  validates :profile, presence: true, unless: :admin?
  validates :password, confirmation: true, presence: true, if: :requires_password?
  validates :password_confirmation, presence: true, if: :requires_password?
  validates :acknowledgement, acceptance: true

  enum title: %w(mr miss ms prof. dr)
  enum gender: %w(female male)
  enum group_solo: { 'Solo' => 0, 'Group' => 1 }
  enum role: { admin: 0, artist: 1, professional: 2 }
  enum residency_status: %w(citizen resident visa)
  enum language_level: %w(advanced intermediate beginner)
  enum education_level: %w(BA BA(Hons) MA PhD BSc MSc Diploma Other)

  enum artist_current_status: ['Represented by', 'Seeking Representation', 'Independent Full-Time', 'Part Time', 'other_artist_status']
  enum professional_current_status: ['Works at', 'Seeking Work', 'Independent', 'Freelance', 'Part-time', 'other_professional_status']

  STATUS_OPTIONS_FOR_ARTIST = artist_current_statuses.keys.map { |s| [s =~ /\A(other)/ ? 'Other' : s.humanize, s] }
  STATUS_OPTIONS_FOR_PROFESSIONAL = professional_current_statuses.keys.map { |s| [s =~ /\A(other)/ ? 'Other' : s.humanize, s] }

  has_paper_trail on: :update, skip: [:password]


  #def title
    #first_name + " " + last_name
  #end

  # this adds my active and passive freinds
  def friends
    active_friends + passive_friends
  end

  def friends_with?(connection)
    active_friends.exists?(connection.id) || passive_friends.exists?(connection.id)
  end

  private

  def requires_password?
    # we allow password to be nil in case of user registration using external authentication
    # strategy. This requires us to ensure that on any other user creation, nil passwords
    # are set to blank (an empty string), which will trigger validation error on password
    (new_record? && !password.nil?) || crypted_password_changed?
  end

end
