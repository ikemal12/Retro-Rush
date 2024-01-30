extends HTTPRequest

var board

#func get_board():
#	# set the parameters for the request
#	var url = "https://api.lootlocker.io/game/leaderboards/11971/list?count=10"
#	var header = ["Content-Type: application/json", "x-session-token: %s" % Lootlocker.token]
#	var method = HTTPClient.METHOD_GET
#
#	# make the request
#	request(url, header, false, method)
#	# wait for the response and convert it into a dictionary
#	var response = yield(self, "request_completed")[3]
#	response = JSON.parse(response.get_string_from_utf8()).result
#
#	# get each item in the dictionary into an array
#	if "items" in response:
#		board = response["items"]

