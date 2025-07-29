class ContentBlocksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson
  before_action :set_content_block, only: [:show, :edit, :update, :destroy, :move]
  before_action :require_instructor_or_admin
  
  def index
    @content_blocks = @lesson.ordered_content_blocks
  end
  
  def show
  end
  
  def new
    @content_block = @lesson.content_blocks.build
    @content_block.block_type = params[:block_type] || 'text'
  end
  
  def create
    @content_block = @lesson.content_blocks.build(content_block_params)
    
    if @content_block.save
      respond_to do |format|
        format.html { redirect_to [@lesson.course, @lesson], notice: 'Content block was successfully created.' }
        format.turbo_stream
        format.json { render json: @content_block }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @content_block.update(content_block_params)
      respond_to do |format|
        format.html { redirect_to [@lesson.course, @lesson], notice: 'Content block was successfully updated.' }
        format.turbo_stream
        format.json { render json: @content_block }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @content_block.destroy
    
    respond_to do |format|
      format.html { redirect_to [@lesson.course, @lesson], notice: 'Content block was successfully deleted.' }
      format.turbo_stream
      format.json { head :no_content }
    end
  end
  
  def move
    new_position = params[:position].to_i
    @content_block.move_to_position(new_position)
    
    respond_to do |format|
      format.json { render json: { status: 'success' } }
      format.html { redirect_to [@lesson.course, @lesson] }
    end
  end
  
  def reorder
    params[:content_block_ids].each_with_index do |id, index|
      ContentBlock.where(id: id, lesson: @lesson).update_all(position: index + 1)
    end
    
    respond_to do |format|
      format.json { render json: { status: 'success' } }
    end
  end
  
  private
  
  def set_lesson
    @lesson = Lesson.find(params[:lesson_id])
  end
  
  def set_content_block
    @content_block = @lesson.content_blocks.find(params[:id])
  end
  
  def content_block_params
    params.require(:content_block).permit(:block_type, :content, :file_url, :alt_text, :position, metadata: {})
  end
  
  def require_instructor_or_admin
    unless current_user&.instructor? || current_user&.admin?
      redirect_to root_path, alert: 'Access denied. Instructor or admin privileges required.'
    end
  end
end
