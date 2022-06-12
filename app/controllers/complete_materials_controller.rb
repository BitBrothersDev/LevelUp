class CompleteMaterialsController < ApplicationController
  before_action :find_learning_material, :find_current_user, only: :create

  def create
    if @user.present?
      if @learning_material.complete_material.blank?
        @complete_material = CompleteMaterial.new(
          is_completed: params[:is_completed],
          user_id: @user.id,
          learning_material_id: @learning_material.id
        )
        @complete_material.save
      else
        @complete_material = @learning_material.complete_material
        @complete_material.update(is_completed: params[:is_completed])
      end
    end
  end

  private

  def find_learning_material
    @learning_material = LearningMaterial.find(params[:learning_material_id])
  end

  def find_current_user
    @user = User.find_by(id: current_user&.id)
  end
end
