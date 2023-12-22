class Post < ApplicationRecord
    before_validation :strip_whitespaces

    validates :title, presence: true, length:{minimum:3, maximum:120}
    validates :content, presence: true

    def strip_whitespaces
        self.title = title.strip if title.present?
        self.content = content.strip if content.present?
    end
end
