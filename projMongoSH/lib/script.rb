require 'mongo'

client = Mongo::Client.new('mongodb://127.0.0.1:27017/test')

collection = client[:people]

collection.delete_many({})

docs = [ { _id: 1, name: 'Steve', hobbies: [ 'hiking', 'tennis', 'fly fishing' ] },
         { _id: 2, name: 'Sally', hobbies: ['skiing', 'stamp collecting' ] } ]

collection.insert_many(docs)
#result.inserted_count # returns 2 because two documents were inserted

doc = { _id: 3, name: 'Jobs', hobbies: [ 'nadar', 'tennis', 'fly fishing' ] }

collection.insert_one(doc)

lista = collection.find({})

lista.each do |e|
	puts e
end