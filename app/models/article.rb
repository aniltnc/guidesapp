class Article < ApplicationRecord
    include Visible

    has_many :comments  
    #comments ile Article arasındaki bağlantıyı sağlıyor
    
    validates :title, presence: true, uniqueness: true, length:{ minimum: 2}
    # aynı title kullanılamaz

    validates :body ,presence: true, length:{ minimum: 10}
    # verinin body si 10 characterden kısa olmamalı
    

end