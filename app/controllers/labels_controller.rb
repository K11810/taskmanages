class LabelsController < ApplicationController

  def create
    @label = Label.new(label_params)
    @label.save
    redirect_to root_path, notice: "ラベルを作成しました"
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to labels_path, notice: "ラベルを削除しました"
  end

  private
  def label_params
    params.require(:label).permit(:name)
  end

end
