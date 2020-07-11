# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  title      :string(255)
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Board < ApplicationRecord
  # [MEMO] has_manyの場合は複数形
  # [MEMO] dependentをつけると削除された際に関連するデータもまとめて削除してくれる
  #        dependentにはdestroyもあり、1つ1つデータを消す挙動になる。基本delete_allで関連の関連など複雑な削除はdestroyを指定する
  has_many :comments, dependent: :delete_all
  # [MEMO] 中間テーブルを介してリレーションするモデルは2つ書く
  has_many :board_tag_relations, dependent: :delete_all
  has_many :tags, through: :board_tag_relations

  # [MEMO] presenceは必須かどうか
  validates :name, presence: true, length: {maximum: 10}
  validates :title, presence: true, length: {maximum: 30}
  validates :body, presence: true, length: {maximum: 1000}
end
