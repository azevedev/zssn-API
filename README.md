# ZSSN - Zombie Survival Social Network

> A RoR API to help folks on a time of need. And also to showcase some Back-End Development skills.

## Table of contents
* [Technologies](#technologies)
* [Setup](#setup)
* [Tests](#tests)
* [Basic Usage](#basic-usage)
* [EndPoints](#endpoints)
* [Todo](#todo)
* [License](#license)
	
## Technologies
This project was created using:
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
  
  ### example:
  ``` 
  	GET http://127.0.0.1:3000/api/v1/survivors
  ```
  
### POST /api/v1/survivors
  > Create a new survivor
  
  #### params:
    name: A name (String) for the survivor (*required)
    age: A number (Integer) for the survivor age (*required)
    gender: "Male" or "Female" (*required)
    latitude: A number (Float) of the latitude of the survivor (*required)
    longitude: A number (Float) of the longitude of the survivor (*required)
    items: An array of items the survivor has, in the form "[ [item_name, item_amount], [item_name, item_amount], [item_name, item_amount]... ]" (*required)
    capacity: A number that represents the amount of weight one survivor can carry
  ### example:
    POST http://127.0.0.1:3000/api/v1/survivors?name='UserName'&age=20&gender='Female'&latitude=1234&longitude=4321&items=[["watter", 2], ["food",4 ]]

### GET	/api/v1/survivors/:id
  > Get one single survivor
  
  #### params:
    id: The id of the survivor (*required)
  ### example: 
    GET http://127.0.0.1:3000/api/v1/survivors/1
	
### PUT	/api/v1/survivor/:id/location
  > Update the location of one survivor
  
  ### params:
  	id: The id of the survivor (*required)
	latitude: The latitude of the survivor (*required)
	longitude: The longitude of the survivor (*required)
  ### example:
    PUT	/api/v1/survivor/1/location?latitude="123",logintude="321"
  	
### POST /api/v1/trades
  > Create a trade betweens two survivors
  ### params: 
     survivor1_id: The id for the first trader (*required)
     survivor2_id: The id for the first trader (*required)
     items_s1: An array of items that survivor1 wants to trade (*required)
     items_s2: An array of items that survivor2 wants to trade (*required)
  ### example:
  	PUT http://127.0.0.1:3000/api/v1/trades?survivor1_id=4&survivor2_id=5&items_s1=[["food", 2], ["medication", 2], ["food", 2]]&items_s2=[["food", 2], ["ammunition", 2], ["food", 2]]
### GET	/api/v1/reports/:type
   > Get one of the reports available from the API
   
   ### params:
     type: The type of report desirable (*required). All types are:
     
       1 - Percentage of infected survivors
       2 - Percentage of non-infected survivors
       3 - Average amount of each kind of resource by survivor
       4 - Points lost because of infected survivors
   ### example:
   	GET http://localhost:3000/api/v1/reports/3 

### POST /api/v1/report/:id
  > Report a single survivor as infected. If one survivor gets 3 or more reports, then it's marked as infected (flagged)
  
  ### params:
  	id: The id of the survivor to be reported
  ### example: 
  	POST http://localhost:3000/api/v1/report/3
	
### GET	/api/v1/status
  > Get the current status of the API
  ### example: 
   	GET http://localhost:3000/api/v1/status

## ToDo
  * Better way of authentication (API Key or Login before any action)
  * Create storage os coins, like a market place
  * Add filttering to some methods (e.g. limit the number of survivors on a request, only get non-infected survivors, etc)
  

## License

This project is 100% open source. Use it however you like it.
