/*
  Maze Generator.
  Written in Processing 3.
*/



public class Maze1{
	public Maze1(int rows, int cols){
		this.rows = rows;
		this.cols = cols;

		this.grid = new Cell[rows][cols];
		wallList = new ArrayList();
		generateCells();
		generateMaze();
	}

	private void generateMaze(){
		Cell currentCell = grid[int(random(rows))][int(random(cols))];

		firstCell = currentCell;
		insertCellToMaze(currentCell, null);

		while (!wallList.isEmpty()) {
			Wall currentWall = wallList.get(int(random(wallList.size())));

			if(!currentWall.isEdge){
				if(!(currentWall.c1.isInMaze && currentWall.c2.isInMaze)){
					currentWall.toOpenWall();

					if(currentWall.c1.isInMaze){
						insertCellToMaze(currentWall.c2, currentWall);
					}
					else{
						insertCellToMaze(currentWall.c1, currentWall);
					}
				}
			}
			wallList.remove(currentWall);
		}

		do{
			endCell = grid[int(random(rows))][int(random(cols))];
		} while(firstCell == endCell);
	}

	//Inserts the cell to the maze and its walls, but skip one of the wall.
	private void insertCellToMaze(Cell pCell, Wall skipWall){
		pCell.setIsInMaze();
		for (Wall wall : pCell.walls) {
			if(wall != skipWall){
				wallList.add(wall);
			}
		}
	}

	//Initializes the grid of cells
	private void generateCells(){
		for (int i = 0; i < rows; ++i) {
			for (int j = 0; j < cols; ++j) {
				grid[i][j] = new Cell(i, j);
			}
		}
		generateWalls(); //Set all the walls of the maze.
	}

	//Initializes the walls of cells
	private void generateWalls() {
		for (int i = 0; i < rows; ++i) {
			for (int j = 0; j < cols; ++j) {
				
				// FIX TOP WALL		
				if(i == 0){
					grid[i][j].walls[0] = new Wall();
					grid[i][j].walls[0].c1 = grid[i][j];
					grid[i][j].walls[0].setIsEdge();
				}else{
					grid[i][j].walls[0] = grid[i-1][j].walls[1]; //The top wall is the same that the bottom wall above the cell.
					grid[i][j].walls[0].c2 = grid[i][j];
				}

				//FIX BOTTOM WALL
				grid[i][j].walls[1] = new Wall();
				grid[i][j].walls[1].c1 = grid[i][j];
				if(i == rows-1){
					grid[i][j].walls[1].setIsEdge();
				}

				//FIX LEFT WALL
				if(j == 0){
					grid[i][j].walls[2] = new Wall();
					grid[i][j].walls[2].c1 = grid[i][j];
					grid[i][j].walls[2].setIsEdge();
				}else{
					grid[i][j].walls[2] = grid[i][j-1].walls[3]; //The left wall is the same that the right wall of the previous cell.
					grid[i][j].walls[2].c2 = grid[i][j];
				}

				//FIX RIGHT WALL
				grid[i][j].walls[3] = new Wall();
				grid[i][j].walls[3].c1 = grid[i][j];
				if(j == cols-1){
					grid[i][j].walls[3].setIsEdge();
				}
			}
		}
	}

	int rows;
	int cols;

	Cell firstCell;
	Cell endCell;

	Cell[][] grid;
	ArrayList<Wall> wallList;
}
