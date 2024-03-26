Database Schema:

Our database schema supports user authentication and storing text-SHA256 pairs:

sql

CREATE TABLE "user" (
    user_id  CHAR(64)   PRIMARY KEY, -- a SHA256 token for web requests
    name     TEXT       NOT NULL,
    credit   BIGINT     DEFAULT 0 -- credits in cents
);

CREATE TABLE hash_text (
    hash     CHAR(64)   PRIMARY KEY,
    text     TEXT
);

REST API Endpoints:

    GET /user/me: Returns user information for the caller.
    POST /text: Accepts text, hashes it, and returns the SHA256 hash.
    GET /text/{hash}: Returns the text associated with a given hash.

All endpoints require a valid X-HashText-User-ID header for user authorization.
Routing with Gorilla Mux:

We utilize Gorilla's mux to set up routes for our endpoints:



package main

import "github.com/gorilla/mux"

func makeRouter() *mux.Router {
    r := mux.NewRouter()
    r.HandleFunc("/user/me", wrapHandler(userHandler)).Methods("GET")
    r.HandleFunc("/text", wrapHandler(textHandler)).Methods("POST")
    r.HandleFunc("/text/{hash}", wrapHandler(textHashHandler)).Methods("GET")
    return r
}

Handler Functions:

We employ wrapHandler() to check user authorization before executing handlers:

func wrapHandler(
    handler func(w http.ResponseWriter, r *http.Request),
) func(w http.ResponseWriter, r *http.Request) {
    // Authorization check logic
}

Authorization and Database Interaction:

Authorization is verified by checking the X-HashText-User-ID header against the database. For instance:



func userIsAuthorized(r *http.Request) bool {
    // Authorization logic
}

Handling Requests and Responses:

Request bodies are processed, and responses are structured accordingly:


func textHandler(w http.ResponseWriter, r *http.Request) {
    // Request handling logic
}

Conclusion and Future Improvements:

The web application demonstrates efficient routing, handling of requests, and database interactions using Go and Gorilla Mux. Future improvements could include enhanced error logging, structured models, dependency injection, improved JSON performance, and expanded endpoint functionalities.