module SearchByName
  extend ActiveSupport::Concern

  included do
    scope :search_by_name, -> (text){
      where('lower(name) LIKE lower(?)', "%#{text}%")
        .or(where('name LIKE ?', "%#{text}%"))
        .or(where('name LIKE ?', "%#{Moji.kata_to_hira(text)}%"))
        .or(where('name LIKE ?', "%#{Moji.hira_to_kata(text)}%"))
    }
  end

end
