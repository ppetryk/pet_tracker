This application is intented to gather data from the pet trackers and generate reports based on received data.

## Installation

To make the application running on the local machine, please do the following:

1. Make sure that Ruby, MySQL and Redis on your local machine. Sorry, the application is not dockerized yet
1. Clone this repo
1. Run `bundle install` to install all dependencies in the source folder
1. Set up the MySQL database with the command: `bundle exec rake db:create db:migrate`

## Usage

You can run the application with `rails s`. Please find the request examples you can execute below.

To create a new pet:

```
 curl -X POST -H "Content-Type: application/json" -d '{"pet": {"pet_type": "Dog", "tracker_type": "big", "owner_id": 260, "in_zone": true}}' http://localhost:3000/api/pets
```

To update the pet including updating the tracker status:

```
curl -X PUT -H "Content-Type: application/json" -d '{"pet": {"in_zone": false}}' http://localhost:3000/api/pets/10
```

To query the pet by ID:

```
curl -X GET http://localhost:3000/api/pets/10
```

To receive the pets count outside of the power saving zone:
```
curl -X POST http://localhost:3000/api/pets/not_in_zone
```

The application code is covered with the unit tests and request tests on RSpec. To run all test suite, please use `rspec` command. If you want to run either unit tests or request tests only, you can execute `rspec spec/models` or `rspec spec/requests` respectively.

To conclude, the steps are pretty simple to run the application and tests.
