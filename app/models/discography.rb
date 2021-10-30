class Discography < ApplicationRecord
    mount_uploader :image, DiscographyUploader

    enum tag: { single: 0, album: 1}
end
