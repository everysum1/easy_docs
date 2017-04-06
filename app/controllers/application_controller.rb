class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def test
    render html: "These docs are sooo easy!"
  end
end
