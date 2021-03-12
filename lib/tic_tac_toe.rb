WIN_COMBINATIONS = [
  [0, 1, 2],
  [1, 4, 7],
  [0, 3, 6],
  [0, 4, 8],
  [2, 5, 8],
  [2, 4, 6],
  [3, 4, 5],
  [6, 7, 8],
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  index = user_input.to_i - 1
end


def current_player(board)
  turn_count(board).even? ? 'X' : 'O'
end


def move(board, index, value)
  board[index] = value
end


def position_taken?(board, index)
  if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
    false
  elsif (board[index] == "X" || board[index] == "O")
    true
  end
end


def valid_move?(board, index)
  if position_taken?(board, index)
    return false
  elsif index.between?(0,8) && !position_taken?(board,index)
    return true
  end
end



def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "X" || i == "O"
    counter += 1
  end
end
  return counter
end


def turn(board)
  puts "Please enter 1-9:"
  user_input = gets.strip
  index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      turn(board)
  end
end


def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
    board[combo[1]] == board[combo[2]] &&
    position_taken?(board, combo[0])
  end
end

def full?(board)
  board.none? do |x|
    x == " " || x.nil?
  end
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if win_combo = won?(board)
    board[win_combo.first]
  end
end

def play(board)
  turn(board) until over?(board)
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
