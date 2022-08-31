class Scorecard 
  attr_reader :current_frame, :scores
  def initialize
    @current_frame = 1
    @remaining_rolls = 2
    @final_frame_rolls = 3
    @frame_score = []
    @scores = []
  end

  def take_turn(score)
    @frame_score.push(score)
    # if @current_frame < 10
      spare_bonus(score)
      strike_bonus(score)
      score == 10 ? @remaining_rolls = 0 : @remaining_rolls -= 1
      end_turn
    # end
    # final_frame(score) if @current_frame == 10
  end

  def show_score
    @scores.map{|frame| frame.sum}.sum
  end

  private

  def final_frame(score)
    if @final_frame_rolls = 3
      spare_bonus(score)
      strike_bonus(score)
      @final_frame_rolls = 2

    end
    # if @remaining_rolls == 2 && score == 10
    #   @remaining_rolls = 2
    #    @remaining_rolls
  end


  def end_turn
    if @remaining_rolls == 0
      @scores.push(@frame_score)
      @frame_score = []
      @current_frame += 1
      @remaining_rolls = 2
    end
  end

  def spare_bonus(score)
    if @current_frame > 1 && @current_frame <11
      previous_frame = @scores[@current_frame - 2]
      if previous_frame.sum == 10 && previous_frame.length == 2
      @scores[@current_frame - 2][-1] += score
      end
    end
  end

  def strike_bonus(score)
    if @current_frame > 1 && @current_frame <11
      one_frame_before = @scores[@current_frame - 2]
      two_frames_before = @scores[@current_frame -3]
      if one_frame_before.length == 1
        @scores[@current_frame - 2][-1] += score
      end
    end
    if current_frame > 2
      one_frame_before = @scores[@current_frame - 2]
      two_frames_before = @scores[@current_frame -3]
      if (one_frame_before.length == 1 && 
          two_frames_before.length == 1 && 
          @remaining_rolls != 1)
        @scores[@current_frame - 3][-1] += score
      end
    end
  end
end