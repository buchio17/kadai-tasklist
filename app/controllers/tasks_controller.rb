class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_task, only: [:edit, :update, :destroy]
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に作成されました。'
      redirect_to root_url
    else
      flash[:danger] = 'Taskの正常に作成されませんでした。 / ' + @task.errors.full_messages[0]
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'task は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = 'Task は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
