class BoardsController < ApplicationController
  # [MEMO]
  # 第一引数で実行したいメソッドをシンボルで指定。
  # onlyで対象のアクションを指定できる。シンボルなので%iのリテラルで指定。※文字列は%w
  before_action :set_target_board, only: %i[show edit update destroy]

  def index
    # [MEMO]
    # kaminariを入れるとpageメソッドが追加される。
    # pageパラメータが指定されない場合、kaminariデフォルトの25件が取得される
    # @boards = Board.page(params[:page])

    # [MEMO] クエリの実行タイミングはその変数が実際に参照される時なので、ここでDBアクセスが発生するわけではない
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page])
  end

  def new
    # controllerのインスタンス変数はviewからも参照できる
    # [MEMO] flashで指定することでエラー後に入力していた状態でフォームを表示させることが可能
    @board = Board.new(flash[:board])
  end

  def create
    # DBに保存
    board = Board.new(board_params)
    if board.save
      # [MEMO] flash変数は特別な変数で、次にその変数が参照されるまでセッションに保存される。保存されていない場合はnilが返る
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board
    else
      # [MEMO] 保存に失敗した場合はboardオブジェクトとエラ〜メッセージをflashに格納し、新規作成画面にリダイレクトする
      # 新規作成画面ではboardを使って入力していた値をフォームに反映させることが出来る
      redirect_to new_board_path, flash: {
          board: board,
          error_messages: board.errors.full_messages
      }
    end
  end

  def show
    @comment = Comment.new(board_id: @board.id)
  end

  def edit
    # [MEMO] 更新エラー後の描画の際に更新時のデータを表示するため
    @board.attributes = flash[:board] if flash[:board]
  end

  def update
    if @board.update(board_params)
      flash[:notice] = "「#{@board.title}」の掲示板を編集しました"
      # [MEMO] 特定のモデルの詳細画面にリダイレクトする場合は、オブジェクトを指定するだけで良い
      redirect_to @board
    else
      flash[:board] = @board
      flash[:error_messages] = @board.errors.full_messages
      redirect_back fallback_location: @board
    end
  end

  def destroy
    @board.destroy

    # [MEMO] redirect_toでflashを設定することも可能
    redirect_to boards_path, flash: {notice: "「#{@board.title}」の掲示板は削除されました"}
  end

  private

  def board_params
    # リクエストパラメータからDBに保存するパラメータを抽出する
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end
