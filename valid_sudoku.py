"""Determine if a 9 x 9 Sudoku board is valid. Only the filled cells need to be validated according to the following rules:
Each row must contain the digits 1-9 without repetition.
Each column must contain the digits 1-9 without repetition.
Each of the nine 3 x 3 sub-boxes of the grid must contain the digits 1-9 without repetition.
"""
def isValidSudoku(board):
    
    # each row validation 
    for i in range(9):
        visited = []
        for j in range(9):
            if board[i][j] in visited and board[i][j] != ".":
                print(i,j,visited,board[i][j])
                return False  
            elif board[i][j] != ".":
                visited.append(board[i][j])
             

    # each col validation 
    for i in range(9):
        visited = []
        for j in range(9):
            if board[j][i] in visited and board[j][i] != ".":
                print(i,j,visited,board[i][j])
                return False  
            elif board[i][j] != ".":
                visited.append(board[i][j])
           
    # for 3 x 3 validation 
    """00 01 02  03 04 05  06 07 08 
       10 11 12  13 14 15  16 17 18
       20 21 22  23 24 25  26 27 28
    """


        


if __name__ == "__main__":

    board = [["5","3",".",".","7",".",".",".","."]
            ,["6",".",".","1","9","5",".",".","."]
            ,[".","9","8",".",".",".",".","6","."]
            ,["8",".",".",".","6",".",".",".","3"]
            ,["4",".",".","8",".","3",".",".","1"]
            ,["7",".",".",".","2",".",".",".","6"]
            ,[".","6",".",".",".",".","2","8","."]
            ,[".",".",".","4","1","9",".",".","5"]
            ,[".",".",".",".","8",".",".","7","9"]]

    print(isValidSudoku(board))
 

