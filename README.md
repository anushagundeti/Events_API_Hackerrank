# Ruby on Rails: Github Events API

## Project Specifications

**Read-Only Files**
- spec/*
- db/migrate/*

**Environment**  

- Ruby version: 3.2.2
- Rails version: 7.0.0
- Default Port: 8000

**Commands**
- run: 
```bash
bin/bundle exec rails server --binding 0.0.0.0 --port 8000
```
- install: 
```bash
bin/bundle install
```
- test: 
```bash
RAILS_ENV=test bin/rails db:migrate && RAILS_ENV=test bin/bundle exec rspec
```
    
## Question description

In this challenge, your task is to implement a simple REST API to manage a collection of Github events.

Each Github event has the following structure:

- `id`: The unique ID of the event. (Integer)
- `event_type`: The type of event. (String)
- `public`: Whether the event is public, either `true` or `false`. (Boolean)
- `repo_id`: The ID of the repository the event belongs to. (Integer)
- `actor_id`: The ID of the user who created the event. (Integer)


### Example of an event data JSON object:
```
{
  "id": 1,
  "event_type": "PushEvent",
  "public": true,
  "repo_id": 1,
  "actor_id": 1
}
```

## Requirements:

You are provided with the implementation of the Event model. The REST service must expose the `/events` endpoint, which allows for managing the collection of event records in the following way:

`POST /events`:

- creates a new event
- expects a JSON event object without an id property as the body payload. You can assume that the given object is always valid except that the type might be invalid. A valid type is one of `PushEvent`, `ReleaseEvent`, or `WatchEvent`.
- you can assume that all other values in the payload given to create the object are always valid
- if the given type is invalid, the response code is 400
- if the type is valid, it adds the given event object to the collection of events and assigns a unique integer id to it. The first created event must have id 1, the second one 2, and so on.
- if the type is valid, the response code is 201 and the response body is the created event object, including its id

`GET /events`:

- returns JSON of a collection of all events, ordered by id in increasing order
- returns response code 200

`GET /repos/:repo_id/events`:

- returns a collection of events related to the given repository ordered by id in increasing order
- returns response code 200

`GET /events/:id`:

- returns an event with the given id
- if the matching event exists, the response code is 200 and the response body is the matching event object
- if there is no event in the collection with the given id, the response code is 404
