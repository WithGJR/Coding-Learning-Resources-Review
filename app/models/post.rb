class Post < ActiveRecord::Base
	validates :url, presence: true, uniqueness: true
	validates :title, presence: true
	validates :description, presence: true

	belongs_to :author, :class_name => "User", :foreign_key => "user_id"

  before_create :sanitize_every_part
  before_update :sanitize_every_part

  def reading_version
    self.description = transform_markdown_to_html(self.description)
    self
  end

  private

	def transform_markdown_to_html(content)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :hard_wrap => true)
    ActionController::Base.helpers.sanitize(markdown.render(content).html_safe)
	end

  def sanitize_every_part
    needed_sanitized_parts = [:url, :title, :description]

    needed_sanitized_parts.each do |part|
      self[part] = ActionController::Base.helpers.sanitize self[part]
    end
  end
  
end
