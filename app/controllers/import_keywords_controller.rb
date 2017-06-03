class ImportKeywordsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!

  def create
    import_keyword = ImportKeyword.new import_keyword_params
    if import_keyword.save
      flash[:success] = I18n.t "message.keyword.create.success"
    else
      flash[:error] = import_keyword.errors.full_messages.join(",")
    end
    redirect_to root_path
  end

  private
  def import_keyword_params
    keywords_params = params.require(:import_keyword).permit!
    keywords_params.merge user_id: current_user.id
  end
end
