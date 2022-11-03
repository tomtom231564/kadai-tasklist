class TasksController < ApplicationController
  before_action :require_user_logged_in#課題に合わせて挿入
  before_action :correct_user, only: [:destroy,:show,:update,:edit]
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    #indexアクションの役割はmessegeモデルのレコードの一覧表示
    #@messageはインスタンス変数　Message.allはraillのライブラリの記述
      #@tasks = Task.all
    @pagy, @tasks = pagy(current_user.tasks.order(id: :desc), items: 25)
  end

  def show
    #indexと違ってidを受け取っている
    #URLパラメーターやデータはすべてparamsで受け取り
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    #@task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    #@message.saveは失敗するとfalseを返すため、成功した場合と失敗した場合を書く
    if task.save
      #flashはflashメッセージを出す別ファイルをベット作る
      flash[:success] = 'Task が正常に投稿されました'
      #redirect_to はリンク先を指定して強制的に飛ばすメソッド
      redirect_to new
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      #render :new は、単に messages/new.html.erb を表示するだけ
      render :new
    end
  end
  
  

  def edit
    task = current_user.tasks.find(params[:id])
    #@task = Task.find(params[:id])
  end

  def update
    #@task = current_user.tasks.build(task_params[:id])
     @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    #リダイレクトするときだけはprefix + _url
    redirect_to root_url
  end
  
  private
  
  # Strong Parameter
  def task_params
    #Messageモデルのフォームから得られるデータに関するものだと明示し、
    #.permit(:content) で必要なカラムだけを選択しています。
    params.require(:task).permit(:status,:content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  
  
end
