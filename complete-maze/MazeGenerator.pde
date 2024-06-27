/*
	Maze Generator.
  Written in Processing 3.
*/

import processing.sound.*;
SoundFile file;

int WIDTH = 500; //WIDTH OF THE WINDOW'S SCREEN
int HEIGHT = 500; //HEIGHT OF THE WINDOW'S SCREEN
int CELL_SIZE = 25; //CELL SIDE LENGTH

//COLORS
color COLOR_START_SQUARE = color(255, 0, 0);
color COLOR_FINISH_SQUARE = color(0, 0, 255);
color COLOR_PLAYER_SQUARE = color(0, 255, 0);

Maze1 maze;
Player player;

int numStars = 100;  // Number of stars
int[] starX = new int[numStars];
int[] starY = new int[numStars];
int[] starSize = new int[numStars];
int[] starBrightness = new int[numStars];


void setup(){
	size(500, 500);
  // Load a soundfile from the /data folder of the sketch and play it back
  file = new SoundFile(this, "sound.mp3");
  file.play();

	maze = new Maze1(WIDTH/CELL_SIZE, HEIGHT/CELL_SIZE); //Adaptive maze, screen size divided by the size of the cell
	player = new Player(maze.firstCell.x, maze.firstCell.y); // The X & Y of the player are the same that first cell of the maze.

    // Generate random positions and sizes for stars
  for (int i = 0; i < numStars; i++) {
    starX[i] = int(random(width));
    starY[i] = int(random(height));
    starSize[i] = int(random(1, 4));
    starBrightness[i] = int(random(100, 255));
  }

}

void draw(){
	background(0);
	strokeWeight(1);
// Draw the stars
  for (int i = 0; i < numStars; i++) {
    fill(starBrightness[i]);
    noStroke();
    ellipse(starX[i], starY[i], starSize[i], starSize[i]);
  }

	// First Cell position
	stroke(COLOR_START_SQUARE);
	fill(COLOR_START_SQUARE);
	rect(maze.firstCell.y * CELL_SIZE, maze.firstCell.x * CELL_SIZE, CELL_SIZE, CELL_SIZE);

	// Player's position
	stroke(COLOR_PLAYER_SQUARE);
	fill(COLOR_PLAYER_SQUARE);
	rect(player.y * CELL_SIZE, player.x * CELL_SIZE, CELL_SIZE, CELL_SIZE);

	// End Cell position
	stroke(COLOR_FINISH_SQUARE);
	fill(COLOR_FINISH_SQUARE);
	rect(maze.endCell.y * CELL_SIZE, maze.endCell.x * CELL_SIZE, CELL_SIZE, CELL_SIZE);

	//draw the maze
	strokeWeight(1.2);
	stroke(#ffffff);
	for (Cell1[] cells : maze.grid) {
		for (Cell1 cell : cells) {
			if(!cell.walls[3].isOpen){
				line(cell.y * CELL_SIZE + CELL_SIZE, cell.x * CELL_SIZE, cell.y * CELL_SIZE + CELL_SIZE, cell.x * CELL_SIZE + CELL_SIZE);
			}

			if(!cell.walls[1].isOpen){
				line(cell.y * CELL_SIZE, cell.x * CELL_SIZE + CELL_SIZE, cell.y * CELL_SIZE + CELL_SIZE, cell.x * CELL_SIZE + CELL_SIZE);
			}
		}
	}

	if(maze.endCell.x == player.x && maze.endCell.y == player.y){
		resetMaze();
	}
}

void resetMaze(){
	maze = new Maze1(WIDTH/CELL_SIZE, HEIGHT/CELL_SIZE);
	player = new Player(maze.firstCell.x, maze.firstCell.y);
}

void keyReleased(){
	if(keyCode == UP && maze.grid[player.x][player.y].walls[0].isOpen){
		player.x -=1;
	}
	else if(keyCode == DOWN && maze.grid[player.x][player.y].walls[1].isOpen){
		player.x +=1;
	}
	else if(keyCode == LEFT && maze.grid[player.x][player.y].walls[2].isOpen){
		player.y -=1;
	}
	else if(keyCode == RIGHT && maze.grid[player.x][player.y].walls[3].isOpen){
		player.y +=1;
	}
}
