# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#

Server.create(hostname: 'fedora.example.com', ip: '192.198.100.23', os: 'Fedora 38')
Server.create(hostname: 'ubuntu.example.com', ip: '192.198.100.11', os: 'Ubuntu 18.04', ram_mb: '64000')
