class News < ApplicationRecord
    mount_uploader :image, NewsUploader
end
