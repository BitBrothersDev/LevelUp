module ApplicationHelper
  # include Pagy::Frontend

  def is_active(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end
end
