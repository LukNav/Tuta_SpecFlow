Feature: reqresTest
	As an admin
	I want to view user info
	So that I can know their information

Background:
	Given I am using the base url as 'https://reqres.in/api/users/'

Scenario Outline: As a Service I provide back user information
	Given I setup the request to GET using the provided '<ID>' as value
	When I send the request through
	Then I should receive a response back
	And I should have received a status code of <responseCode>
	And I validate first_name should have '<first_name>' value
	And I validate last_name should have '<last_name>' value

	Examples: 
	| ID | responseCode | first_name  | last_name |
	| 1  | 200          | George	  | Bluth     |
	| 2  | 200          | Janet       | Weaver    |
	| 23 | 404          | error		  | error     |