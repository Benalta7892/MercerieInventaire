class Users::SessionsController < Devise::SessionsController
  def destroy
    demo_user_id = session.delete(:demo_user_id)

    super

    User.find_by(id: demo_user_id)&.destroy if demo_user_id.present?
  end
end
