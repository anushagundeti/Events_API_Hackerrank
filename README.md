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

id: Auto-assigned integer

event_type: Must be one of "PushEvent", "ReleaseEvent", "WatchEvent"

public: Boolean

repo_id: Integer

actor_id: Integer

🎯 API Endpoints
🔹 POST /events
Create a new event

Validations:

Only accepts valid event_type values

ID is auto-assigned (starts at 1)

Responses:

201 Created with full event JSON (if valid)

400 Bad Request if event_type is invalid

🔹 GET /events
Returns all events, ordered by id ascending

Response: 200 OK with event array

🔹 GET /events/:id
Returns a single event by ID

Responses:

200 OK with event JSON (if found)

404 Not Found if not found

🔹 GET /repos/:repo_id/events
Returns all events belonging to a specific repository

Ordered by id ascending

Response: 200 OK with event array

🛠️ Getting Started
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
3. Run the Rails server
bash
Copy
Edit
bin/bundle exec rails server --binding 0.0.0.0 --port 8000
Visit: http://localhost:8000/events

🧪 Running Tests
RSpec tests are already set up under the spec/ folder

Run the test suite:

bash
Copy
Edit
RAILS_ENV=test bin/rails db:migrate
RAILS_ENV=test bin/bundle exec rspec
🧱 Routes Overview
http
Copy
Edit
POST   /events                 → events#create
GET    /events                 → events#index
GET    /events/:id             → events#show
GET    /repos/:repo_id/events  → events#index_by_repo
📁 Project Structure
arduino
Copy
Edit
.
├── app/
│   └── controllers/
│       └── events_controller.rb
├── db/
│   └── migrate/
├── spec/
│   └── requests/
│       └── events_spec.rb
├── config/
│   └── routes.rb
├── bin/
│   └── bundle, rails, etc.
└── README.md
✅ Example cURL Commands
Create a valid event:
bash
Copy
Edit
curl -X POST http://localhost:8000/events \
  -H "Content-Type: application/json" \
  -d '{"event_type": "PushEvent", "public": true, "repo_id": 1, "actor_id": 1}'
Create an invalid event (bad type):
bash
Copy
Edit
curl -X POST http://localhost:8000/events \
  -H "Content-Type: application/json" \
  -d '{"event_type": "InvalidEvent", "public": true, "repo_id": 1, "actor_id": 1}'
