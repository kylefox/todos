class Todo < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }

  scope :completed, -> { where(completed: true) }
  scope :incomplete, -> { where(completed: false) }
  scope :recent, -> { order(created_at: :desc) }

  # Broadcasting for real-time updates
  after_create_commit -> { broadcast_prepend_to "todos" }
  after_update_commit -> { broadcast_replace_to "todos" }
  after_destroy_commit -> { broadcast_remove_to "todos" }
end
