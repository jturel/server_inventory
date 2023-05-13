# Server Inventory
A shockingly feature-rich application for managing your collection of servers!

One of the best features is Webhooks notification. Creating and updating servers will notify consumers of the changes. We're still figuring out how to get it working when deleting servers so stay tuned.

## Requirements
- Ruby >= 3.2.2 (probably much less in reality, but this is what we develop against)

## Setup
- `bundle install`
- `bundle exec rake db:setup`
- `bundle exec rails s`

## API

### Creating a server
```
curl http://localhost:3000/api/v1/servers -X POST -d '{"hostname": "newserver.example.com", "os": "Windows 98 Second Edition", "ip": "192.168.100.2", "ram_mb": "128"}' -H 'Content-type: application/json' | jq
```

**Response**
```
{
  "id": 3,
  "created_at": "2023-05-13T17:00:19.437Z",
  "updated_at": "2023-05-13T17:00:19.437Z",
  "hostname": "newserver.example.com",
  "os": "Windows 98 Second Edition",
  "ip": "192.168.100.2",
  "ram_mb": 128
}
```

### Updating a server
```
curl http://localhost:3000/api/v1/servers/1 -X PUT -d '{"hostname": "foo", "os": "test", "ip":"locals"}' -H 'Content-type: application/json' | jq
```
**Response**
```
{
  "hostname": "foo",
  "os": "test",
  "ip": "locals",
  "ram_mb": null,
  "id": 1,
  "created_at": "2023-05-11T02:32:46.321Z",
  "updated_at": "2023-05-13T16:50:39.443Z"
}
```

### Errors
Errors are returns within the `errors` key of the response body if there are any:
```
curl http://localhost:3000/api/v1/servers -X POST -d '{"hostname": "foo"}' -H 'Content-type: application/json' | jq
```

**Response**
```
{                                                                         
  "error": "Validation failed: Os can't be blank, Ip can't be blank"      
}   
```

## Configuring Webhooks
Consumers are defined in `data/server-subscribers.yml` Each entry must specify the `url` that we will send events to as well as a `key` The key is used as part of a [HMAC scheme](https://en.wikipedia.org/wiki/HMAC) so that clients can verify the contents of the events that we send them. The YAML is read every time an event is fired which means the data can be updated without needing to restart the application.

The system is built on top of ActiveJob via ActiveRecord lifecycle callbacks. If any consumers are unreachable an error is logged and the remaining consumers are notified.

### Example Event
```
{
  "payload": {
    "id": 3,
    "created_at": "2023-05-13T17:00:19.437Z",
    "updated_at": "2023-05-13T17:00:19.437Z",
    "hostname": "newserver.example.com",
    "os": "Windows 98 Second Edition",
    "ip": "192.168.100.2",
    "ram_mb": 128
  },
  "event": "server.created"
}
```

## Testing

Tests are currently passing. Don't break them because we don't have a github workflow to run them yet.
```
bundle exec rails test -v
Running 7 tests in a single process (parallelization threshold is 50)
Run options: -v --seed 59094

# Running:

Api::V1::ServersControllerTest#test_update_no_params = 0.22 s = .
Api::V1::ServersControllerTest#test_update_unknown_host = 0.00 s = .
Api::V1::ServersControllerTest#test_create = 0.01 s = .
Api::V1::ServersControllerTest#test_create_no_params = 0.00 s = .
Api::V1::ServersControllerTest#test_update = 0.01 s = .
Webhooks::NotifierTest#test_verify_signature = 0.02 s = .
NotifyServerSubscribersTest#test_perform = 0.00 s = .

Finished in 0.277089s, 25.2626 runs/s, 28.8716 assertions/s.
7 runs, 8 assertions, 0 failures, 0 errors, 0 skips
```
