class Racer
  # Add Active Model support.
  # Provides constructor that takes a Hash of attribute values.
  include ActiveModel::Model

  # Add Active Model validation support to Book class.
  include ActiveModel::Validations

  validates :first_name, :last_name, presence: true

  attr_accessor :racer_id, :bid_number, :first_name, :last_name

  # Return a Google::Cloud::Firestore::Dataset for the configured collection.
  # The collection is used to create, read, update, and delete entity objects.
  def self.collection
    project_id = ENV["GOOGLE_CLOUD_PROJECT"]
    raise "Set the GOOGLE_CLOUD_PROJECT environment variable" if project_id.nil?

    require "google/cloud/firestore"
    firestore = Google::Cloud::Firestore.new project_id: project_id
    @collection = firestore.col "racers"
  end

  def self.all
   racers = []
   Racer.collection.get do |racer|
     racers << Racer.new(racer.data)
   end
   racers
  end

  def self.find id
    racer = Racer.collection.doc(id).get
    Racer.new(racer.data) if racer.data
  end

  def save
    if valid?
      racer_ref = Racer.collection.doc racer_id
      racer_id = !bid_number.nil? ? bid_number : Racer.collection.get.count + 1
      racer_ref.set \
        first_name: first_name,
        last_name:  last_name,
        racer_id:   racer_ref.document_id,
        bid_number: racer_id     
      true
    else
      false
    end
  end
 end
