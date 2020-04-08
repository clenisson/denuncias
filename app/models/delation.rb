class Delation < ApplicationRecord
  belongs_to :user

  validates :description, presence: { message: "Descreva a denúncia" }, on: :create
  validates :latitude, presence: { message: "Informe a latitude" }, on: :create
  validates :longitude, presence: { message: "Informe a longitude" }, on: :create
  validates :resolution, presence: {message: "Informe a medida adotada"}, on: :update
end
