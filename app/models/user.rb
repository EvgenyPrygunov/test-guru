class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :own_tests, class_name: 'Test', foreign_key: 'author_id'
  has_many :gists
  has_many :feedbacks
  has_many :badge_users
  has_many :badges, through: :badge_users

  def test_passage(test)
    test_passages.order(created_at: :desc).find_by(test_id: test.id)
  end

  def full_name
    first_name + " " + last_name
  end

  def admin?
    is_a?(Admin)
  end

  def correct_passed_tests
    test_passages.where(passed: true)
  end

  def correct_passed_tests_count_by_level(level)
    correct_passed_tests.joins(:test).where(tests: { level: level }).count
  end
end
