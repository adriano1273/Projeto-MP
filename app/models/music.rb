class Music < ApplicationRecord
    validates :title, :description, presence: true
    def descricao
        "Música: " + self.title.to_s + "; Descrição: " + self.description.to_s
    end 
end

