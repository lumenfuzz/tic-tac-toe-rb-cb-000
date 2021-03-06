WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

# Helper Methods
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  index = 9
  until valid_move?(board, index)
    puts "Please enter 1-9:"
    input = gets.strip
    index = input_to_index(input)
  end
    move(board, index, current_player(board))
    display_board(board)
end

def turn_count(board)
  counter = 0
  board.each do |index|
    if index == "X" || index == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  result_val = nil
  dummy = WIN_COMBINATIONS.each do |win|
    (board[win[0]] == "X" && board[win[1]] == "X" && board[win[2]] == "X") ||
    (board[win[0]] == "O" && board[win[1]] == "O" && board[win[2]] == "O") ?
    result_val = win : nil
  end
  result_val
end

def full?(board)
  !(board.any?{|i| i == "" || i == " "})
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || full?(board) || draw?(board)
end

def winner(board)
  win_val = won?(board)
  if win_val == nil
    nil
  else
    board[win_val[0]]
  end
end

def play(board)
  until over?(board)
    display_board(board)
    puts "Where would you like to go?"
    input = gets.strip
    index = input_to_index(input)
    move(board, index, current_player(board))
  end
  if winner(board) == "X"
    puts "Congratulations X!"
  elsif winner(board) == "O"
    puts "Congratulations O!"
  else
    puts "Cat's Game!"
  end
end
