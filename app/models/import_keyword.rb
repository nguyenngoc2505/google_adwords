class ImportKeyword
  include ActiveModel::Model
  attr_accessor :user_id, :file

  validates :user_id, :file, presence: true

  def save
    return false unless valid?
    if keywords.present?
      keywords.each{|k| CreateKeywordsJob.perform_later user_id, k}
      true
    else
      errors.add :file, "Invalid File"
      false
    end
  end

  private
  def keywords
    @keywords ||= ParseKeywordsService.new(file).extract
  end
end
