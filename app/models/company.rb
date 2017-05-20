class Company < ActiveRecord::Base
  has_many :members, class_name: 'User', foreign_key: 'company_id'

  has_many :exhibitions, foreign_key: 'venue_id'
  has_many :represented_exhibitions, class_name: 'Exhibition', foreign_key: 'representation_id'

  has_many :company_memberships
  has_many :members, through: :company_memberships, source: :user

  has_many :approved_members, -> { where company_memberships: { state: 1 } }, through: :company_memberships, source: :user

  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  validates :name, presence: true
  validates :name, uniqueness: true
  #validates :image_url, presence: true, on: :update
  validates :owner, presence: true, if: :owner_id
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, if: :email
  #validates :phone, format: { with: /\A^\+(?:[0-9] ?){6,14}[0-9]$\z/, message: 'Please format your phone number with a country code (ie. +44)' }, if: :phone

  enum position: [:owner, :employee]

  scope :pending, -> { where(owner: nil) }
  scope :active, -> { where.not(owner: nil) }

  def active?
    owner.present?
  end

  def pending?
    !active?
  end

  def organization_types
    OrganizationType.approved.where(id: organization_type_ids).pluck(:name)
  end

end
