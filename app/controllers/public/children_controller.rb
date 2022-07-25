class Public::ChildrenController < ApplicationController

  private

  def child_params
    params.require(:child).permit(:sex, :birth_date)
  end
end
