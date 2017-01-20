class My::ProfilePresenter

  attr_reader :user

  def initialize(user_id)
    @user = User.find(user_id)

    build_education
    build_award
    build_residence
    build_experience
    build_exihibition
    build_bibliography
    build_publication
    build_participation
    build_collection
    build_membership
    build_media_feature
  end

  private

  def build_education
    @user.educations.build if @user.educations.empty?
  end

  def build_award
    @user.awards.build if @user.awards.empty?
  end

  def build_residence
    @user.residencies.build if @user.residencies.empty?
  end

  def build_experience
    @user.experiences.build if @user.experiences.empty?
  end

  def build_exihibition
    @user.exhibitions.build if @user.exhibitions.empty?
  end

  def build_bibliography
    @user.bibliographies.build if @user.bibliographies.empty?
  end

  def build_publication
    @user.publications.build if @user.publications.empty?
  end

  def build_participation
    @user.participations.build if @user.participations.empty?
  end

  def build_collection
    @user.collections.build if @user.collections.empty?
  end

  def build_membership
    @user.memberships.build if @user.memberships.empty?
  end

  def build_media_feature
    @user.media_features.build if @user.media_features.empty?
  end

end
