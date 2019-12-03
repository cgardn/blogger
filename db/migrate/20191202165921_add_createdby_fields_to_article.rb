class AddCreatedbyFieldsToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :created_by,  :string
    add_column :articles, :views,       :integer
  end
end
