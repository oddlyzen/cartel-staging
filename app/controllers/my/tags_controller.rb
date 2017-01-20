module My
  class TagsController < My::BaseController
    ALLOWED_TAGS = %w(Medium Subject Specialisation Skill Language Service OrganizationType Company).freeze

    before_action :whitelist_tag, only: [:create]

    def create
      if @klass
        build_klass
        if @tag.save
          render json: @tag.to_json
        else
          redirect_to root_path, alert: 'This tag is invalid'
        end
      else
        redirect_to root_path, alert: 'This tag type is not available'
      end
    end

    private

    def whitelist_tag
      return if params[:klass].blank?
      @klass = ALLOWED_TAGS.grep(params[:klass]).first&.safe_constantize
    end

    def build_klass
      @tag = if @klass == Company
               @klass.new(name: params[:name])
             else
               @klass.new(user_id: @user.id, name: params[:name])
             end
    end

  end
end
