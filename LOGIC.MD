

We divide the whole world into lat/lng "quadrants" of 1km x 1km

Each quandrant has
	a fixed basis of 50 treasures
	additional treasures depending on logged in users in this quadrant

timer-process every hour

	remove old treasures
	place new treasures
	send PUSH update than quandrant XY has changed!


client

	at startup
	locate my LAT/LNG
	query my quadrant plus 8 surrounding quadrants
	place them on map
	initially, show all treasures

	when lat/lng within 10meters of treasure
		send TAKE TREASURE to server
		respons
			OK (treasure-count--)
			STORE TREASURE IN ACCOUNT!
		else
			error!

	events
		when moving around
		blink/sound when we approach treasure


	========================

	after login
		move some temp treasures "close" to user so he understands the game

		USERLEVEL = NOOB, BEGINNER, NORMAL, PRO, GURU

