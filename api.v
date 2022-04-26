import vweb
import os


const play_map = {
	'failed': 'failed.mp3'
}

struct App{
	vweb.Context
}

['/api/:play_message']
fn (mut app App) hello_user(play_message string) vweb.Result {

	playf := fn (file_name string) int{
				
		return os.system('gst-launch-1.0 filesrc location=assets/$file_name ! mpegaudioparse ! mpg123audiodec ! audioconvert ! autoaudiosink')
	}

	play_file := play_map[play_message] 

	if play_file == '' {
		return app.text('Invalid play message')
	}


	go playf(play_file)

	return app.text('Playing $play_message')
}


fn main(){
	vweb.run(&App{}, 8080)
}