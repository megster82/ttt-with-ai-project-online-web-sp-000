class Game 
  attr_accessor :board, :player_1, :player_2, :winner, :user_input
  
  WIN_COMBINATIONS =  [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 4, 8],
    [2, 4, 6],
    [1, 4, 7],
    [0, 3, 6],
    [2, 5, 8]
    ]
  
  def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board 
    @board.display
  end 
  
  def current_player
    board.turn_count.odd? ? player_2 : player_1
  end
  
  def won?
    WIN_COMBINATIONS.each do |win_combination|
      if @board.cells[win_combination[0]] == @board.cells[win_combination[1]] && @board.cells[win_combination[1]] == @board.cells[win_combination[2]] && @board.taken?(win_combination[0] + 1)
      return win_combination
      end
    end
    return false 
  end
  
  def draw?
    if !won? && @board.full? 
      true 
    else 
      end 
  end 
  
  def over?
    if won? || draw?
      true 
    else
      end 
  end 
  
  def winner
    if won?
      win_combination = won?
      @board.cells[win_combination[0]]
    end 
  end
  
  def turn
    puts "Please enter a number 1-9:"
    @user_input = current_player.move(@board)
    if @board.valid_move?(@user_input)
      @board.update(@user_input, current_player)
    else 
      puts "Please enter a number 1-9:"
      @board.display
      turn
    end
    @board.display
  end

  def play 
    turn until over?
    if won? 
      puts "Congratulations #{winner}!"
    elsif draw?
      puts "Cat's Game!"
    end 
  end
  
end 