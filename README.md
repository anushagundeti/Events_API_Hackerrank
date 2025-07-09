# 🔔 GitHub Events API (Ruby on Rails)

A RESTful API built with **Ruby on Rails 7** to manage a collection of GitHub-style events.  
This project supports creating events, retrieving all events, viewing a specific event by ID, and filtering events by repository — all with proper validations and status codes.

---

## 📌 Project Specs

- Ruby version: `3.2.2`
- Rails version: `7.0.0`
- Default Port: `8000`
- Test Framework: `RSpec`
- Provided model: `Event` (already implemented)
- Files like `spec/*` and `db/migrate/*` are read-only

---

## 🧾 Event JSON Format

Each event includes the following fields:

```json
{
  "id": 1,
  "event_type": "PushEvent",       // Must be PushEvent, ReleaseEvent, or WatchEvent
  "public": true,
  "repo_id": 1,
  "actor_id": 1
}
---

## 🧾 Event Fields

| Field       | Type     | Description                                                  |
|-------------|----------|--------------------------------------------------------------|
| `id`        | Integer  | Auto-assigned unique ID for each event                       |
| `event_type`| String   | Must be one of `"PushEvent"`, `"ReleaseEvent"`, `"WatchEvent"` |
| `public`    | Boolean  | Indicates if the event is public                             |
| `repo_id`   | Integer  | ID of the repository this event belongs to                   |
| `actor_id`  | Integer  | ID of the user who triggered the event                       |

🎯 API Endpoints
🔹 POST /events
Create a new event

Validations:

Only accepts valid event_type values

ID is auto-assigned (starts at 1)

Responses:

201 Created – Returns full event JSON if valid

400 Bad Request – If event_type is invalid

🔹 GET /events
Return all events

Response:

200 OK – Returns an array of events ordered by id

🔹 GET /events/:id
Return a specific event

Responses:

200 OK – If found

404 Not Found – If not found

🔹 GET /repos/:repo_id/events
Return all events belonging to a given repo

Response:

200 OK – Array of events for the repo_id, ordered by id

🚀 Getting Started
1. Clone the repo
bash
Copy
Edit
git clone https://github.com/anushagundeti/github-events-api.git
cd github-events-api
2. Install dependencies
bash
Copy
Edit
bin/bundle install
3. Run the server
bash
Copy
Edit
bin/bundle exec rails server --binding 0.0.0.0 --port 8000
Open in browser or Postman at: http://localhost:8000

🧪 Running Tests
Run the test suite using:

bash
Copy
Edit
RAILS_ENV=test bin/rails db:migrate
RAILS_ENV=test bin/bundle exec rspec

