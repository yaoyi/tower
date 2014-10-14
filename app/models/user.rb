class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time


  field :nickname, type: String
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :projects
  has_many :comments

  def join_project(project)
    projects << project
  end

  def quit_project(project)
    projects.delete(project)
  end

  def join_team(team)
    teams << team
  end

  def quit_team(team)
    teams.delete(team)
  end

  def is?(team, role)
    roles = Access.where(team: team, user: self)
    roles.include?(role.to_s)
  end

  class << self
    def serialize_from_session(key, salt)
      key = key[0]["$oid"] if key[0].kind_of?(Hash)
      record = to_adapter.get(key)
      record if record && record.authenticatable_salt == salt
    end
  end

end
