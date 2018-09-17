#LIFO API documentation

## Endpoints
for all endpoints with token authentication required, include the user's bearer token in the API request

### User endpoints

#### Create New User
POST	/api/v1/users(.:format)	
include username, email, and password fields in your API request params

#### Show User Profile And Questions
GET	/api/v1/users/:id(.:format)	
no authentication required

#### Update User Profile
PATCH	/api/v1/users/:id(.:format)	
include username, email, or password fields in your API request params
token authentication required

#### Delete user Profile
DELETE	/api/v1/users/:id(.:format)	
token authentication required

#### Request Bearer Token
GET	/api/v1/request_token(.:format)
include username and password fields in your API request params
api/v1/users#request_token

### Question endpoints

#### 
GET	/api/v1/questions(.:format)	
api/v1/questions#index

#### 
POST	/api/v1/questions(.:format)	
api/v1/questions#create
token authentication required

#### 
GET	/api/v1/questions/:id(.:format)	
api/v1/questions#show

#### 
PATCH	/api/v1/questions/:id(.:format)	
api/v1/questions#update
token authentication required

#### 
DELETE	/api/v1/questions/:id(.:format)	
api/v1/questions#destroy
token authentication required

### Answer endpoints

#### 
POST	/api/v1/questions/:question_id/answers(.:format)	
api/v1/answers#create
token authentication required

#### 
PATCH	/api/v1/questions/:question_id/answers/:id(.:format)	
api/v1/answers#update
token authentication required

#### 
DELETE	/api/v1/questions/:question_id/answers/:id(.:format)	
api/v1/answers#destroy
token authentication required

### Vote endpoint

#### 
POST	/api/v1/questions/:question_id/answers/:answer_id/votes(.:format)	
api/v1/votes#create
token authentication required


## QuestionBox API

## Description

Modify the QuestionBox application you've been working on this week and add API functionality to it, so that your application can also return JSON data if requested. If you have been working on a team, you can keep working together.

Your application should still work as it currently does, but you should have endpoints that respond to requests for JSON data _in addition_ to the endpoints that serve HTML or JS.

The API should allow all the same CRUD functions that the original application does, including user registration and authentication. Now, your application will allow users to register via api and registered users to request an auth token for making API requests that require authentication (creating and editing capabilities). Note that you don't need to create separate classes of users for the regular application and for the api. You just need to be able to create a new user via an API endpoint.

Your API should be completely documented for developers using your API. The README for your application is a good place to put this documentation, but you could also consider using a tool like [HackMD](https://hackmd.io/).

## Extra Challenges

- Deploy your application to Heroku
- Allow photo or file uploads via API.
- Send email for new user registrations using an email service add-on through Heroku.
- Add documentation for developers in the UI itself (i.e., add some routes to your existing non-api application to render documentation in the browser).
- Implement authentication using a gem. Some options are:
  - [OmniAuth](https://github.com/omniauth/omniauth)
  - [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper)
  - [AuthLogic](https://github.com/binarylogic/authlogic)
  - [Devise](https://github.com/omniauth/omniauth)
