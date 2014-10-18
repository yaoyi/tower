module SoftDelete
  extend ActiveSupport::Concern

  included do
    field :deleted_at, type: DateTime

    # default_scope -> { where(deleted_at: nil) }
    scope :deleted, -> { ne(deleted_at: nil) }
    alias_method :destroy!, :destroy
  end

  def destroy
    run_callbacks(:destroy) do
      if persisted?
        self.set(deleted_at: Time.now.utc)
        self.set(updated_at: Time.now.utc)
      end

      @destroyed = true
    end
    freeze
  end

  def deleted?
    !self.deleted_at.blank?
  end
  def restore
    self.deleted_at = nil
    self.save
  end
end