# ZSSN - Zombie Survival Social Network

> A RoR API to help folks on a time of need. And also to showcase some Back-End Development skills.

## Table of contents
* [Technologies](#technologies)
* [Setup](#setup)
* [Tests](#tests)
* [Basic Usage](#basic-usage)
* [EndPoints](#endpoints)
	
## Technologies
Project was created with:
* Ruby 2.6.3
* Rails 6.0.3
* RSpec Rails 4.0.1
* PostgreSQL

## Setup
To run this project (locally) use:

``` ruby
$ bundle install
$ rails db:create db:migrate db:seed
$ rails s
```


## Tests
To run tests, just use:
```
$ bundle exec rspec
```
## Basic usage

```ruby
$ curl localhost:3000/api/v1/survivors
```
Response:
```json
{
  "total":3,
  "survivors":[
    {"id":1,"name":"Jorge","age":21,"gender":"Male","reports":0,"infected":false},
    {"id":2,"name":"Marge","age":32,"gender":"Female","reports":0,"infected":false},
    {"id":3,"name":"Phill","age":19,"gender":"Male","reports":2,"infected":false}
  ]
}
```
## EndPoints
Here's a list of all End-point from the API with it's respectives arguments:

### GET /api/v1/survivors
  > Get all survivors
  
### POST	/api/v1/survivors
  > Create a new survivor
  
  params:
    - name: A name (String) for the survivor (*required)
    - age: A number (Integer) for the survivor age (*required)
    - gender: "Male" or "Female" (*required)
    - latitude: A number (Float) of the latitude of the survivor (*required)
    - longitude: A number (Float) of the longitude of the survivor (*required)
    - items: An array of items the survivor has, in the form "[ [item_name, item_amount], [item_name, item_amount], [item_name, item_amount]... ]"
    - capacity: A number that represents the amount of weight one survivor can carry

### GET	/api/v1/survivors/:id
  > Get one single survivor
  
  
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gerencianet/gn-api-sdk-ruby. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](LICENSE).
