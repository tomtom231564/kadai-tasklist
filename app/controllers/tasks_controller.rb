class TasksController < ApplicationController
  #before_action :set_task, only: [:show, :edit, :update, :destroy]
  
   def index
    #indexアクションの役割はmessegeモデルのレコードの一覧表示
    #@messageはインスタンス変数　Message.allはraillのライブラリの記述
    @tasks = Task.all
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
    @task = Task.new(task_params)
    #@message.saveは失敗するとfalseを返すため、成功した場合と失敗した場合を書く
    if @task.save
      #flashはflashメッセージを出す別ファイルをベット作る
      flash[:success] = 'Task が正常に投稿されました'
      #redirect_to はリンク先を指定して強制的に飛ばすメソッド
      redirect_to @task
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      #render :new は、単に messages/new.html.erb を表示するだけ
      render :new
    end
  end
  
  

  def edit
    @task = Task.find(params[:id])
  end

  def update
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
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    #Messageモデルのフォームから得られるデータに関するものだと明示し、
    #.permit(:content) で必要なカラムだけを選択しています。
    params.require(:task).permit(:content)
  end
  
end
