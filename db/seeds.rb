require 'csv'

csv_text = File.read(Rails.root.join('lib/seeds/riders.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'UTF-8')
csv.each do |row|
  next unless Rider.where(name: row['name']).empty?

  rider = Rider.new
  rider.name = row['name']
  rider.team = row['team']
  rider.country = row['country']
  rider.price = row['price']
  rider.previous_score = row['previous_score']
  rider.score = row['score']
  rider.save
end
