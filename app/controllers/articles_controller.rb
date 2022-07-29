class ArticlesController < ApplicationController
  # create, destroy ve update sayfaları kullanıcıya gösterilmez
  # <% %> ruby'e çevirir
  # <%= %> kullanıcıya gösterir
  #article(herhangi bir veri)
  
  def index   # main menu/ ana sayfa
    @articles = Article.all     # all article'ları @articles'e ata
  end

  def show
    @article= Article.find(params[:id])   # verinin parametre id'sini göster
  end

  def new
    @article=Article.new      # ...articles/new sayfasına yönlendir
  end

  def create
    @article=Article.new(article_params)  # new user oluşturup show'daki tanımlı @article'a yaz
    @article.status = "public"
    if @article.save   
      redirect_to @article    # oluşan userı veri tabanına kayıt edip show sayfasına gönder
    else
      render :new, status: :unprocessable_entity  # kayıt edilmez isenew sayfasını renderlayıp status ü kontrol et ve hatayı yazdır
    end
  end

  def edit
    @article= Article.find(params[:id])  # id'si girilen usersı editleme sayfasına götürür
  end

  def update
    @article=Article.find(params[:id])  # id'si girilen usersı güncelleme
    
    if @article.update(article_params)  
      redirect_to @article      # @article güncelleyip  show sayfasına götür
    else
      render :edit, status: :unprocessable_entity
    end 
  end

  def destroy
    @article=Article.find(params[:id])  # id'si girilen @article bul
    @article.destroy                    # ve sil

    redirect_to root_path, status: :see_other # diğer kullancıların olduğu sayfaya götür
  end

  private
  def article_params    #create ve updatte kullanılacak article_paramsı oluşturma
    params.require(:article).permit(:title, :body, :status) # article title ve body iznini istemesi
  end
end