class Live < ApplicationRecord
    mount_uploader :image, LiveUploader
end
