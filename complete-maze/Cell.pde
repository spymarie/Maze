/*
  Maze Generator.
  Written in Processing 3.
*/

public class Cell1{
	public Cell1(int x, int y){
		this.x = x;
		this.y = y;
		this.isInMaze = false;;
		this.walls = new Wall[4];
	}

	public void setIsInMaze(){
		this.isInMaze = true;
	}

	int x;
	int y;
	boolean isInMaze;

	Wall[] walls; // TOP, BOTTOM, LEFT, RIGHT
}
