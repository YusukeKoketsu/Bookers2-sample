class SearchesController < ApplicationController
  def search
    def search
      # 入力、選択された値をparamsで受け取って@~に代入
      # 検索ワードはcontentで、検索対象はmodelで、検索方法はmethod
      @model=params[:model]
      @content=params[:content]
      @method=params[:method]
      # @modelの値がuserだった場合と、bookだった場合で条件分岐をしている。@recordsに入れているのは検索結果
      # ユーザーの検索ならば
      if @model == 'user'
        @records=User.search_for(@content,@method)
      else
        # bookの検索ならば
        @records=Book.search_for(@content,@method)
      end
    end
  end
end
