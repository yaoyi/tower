class Access
    ROLES = %w[supervisor admin member visitor]
    include Mongoid::Document
    include Mongoid::Timestamps
    belongs_to :team
    belongs_to :user
    field :role, type: String
end
