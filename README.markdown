#Challenge

Write a program which uses a provided API.

## API Options

List of Hackathons: http://hackerleague.org/api/v1/hackathons.json
  You can use offset and limit parameters for the hackathons list, so like - http://hackerleague.org/api/v1/hackathons.json?limit=10&offset=1 
Specific Hackathon: You can also get a specific hackathon by using - http://hackerleague.org/api/v1/hackathons/:id/hacks.json 
    
## Installing application

	% git clone https://github.com/jkgit/hack-a-map.git
	% cd hack-a-map/
	% bundle install
	% rake db:migrate
	
## Running application

    % rails server
    
## Running Rails tests (make sure server is running for tests)

    % rake test    
