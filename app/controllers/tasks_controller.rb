class TasksController < ApplicationController
  helper_method :author

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments.paginate(page: params[:page], :per_page => 15)
  end

  def new
    group = Group.find(params[:group_id])
    @task = group.tasks.build
  end

  def create
    group = Group.find(params[:group_id])
    @task = group.tasks.new(task_params)
    if @task.save
      redirect_to group
    else
      render 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "Tarefa atualizada"
      redirect_to @task.group
    else
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if author? || admin?(params[:group_id])
      @task.delete
      flash[:success] = "Operação realizada com sucesso."
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Você não possui autorização para realizar esta operação!"
      redirect_to @task.group
    end
  end

  private

    def task_params
      params.require(:task).permit(:title, :priority, :deadline, :description)
      params[:task].merge!({ user_id: current_user.id })
    end

    def author?
      @task.user == current_user
    end
end
