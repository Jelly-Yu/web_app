class MatchesController < ApplicationController

  layout 'main'
  
  def index
    @matches = Match.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end


  def new
    
    @match = Match.new
    @user = User.find(session[:current_user_id])
    @match.player1 = @user.id
    @match.player2 = User.find(params[:id]).id
    @match.mDate = Date.today 
    if @match.save
      flash.now[:success] = "You have successfully challenged one person!"
    end

  end

  def challenge
    @matches = Match.where(" player2 = ? AND state IS ?", session[:current_user_id] ,nil)
    respond_to do |format|
      format.html 
    end
  end

  def decision
    @match = Match.find(params[:mid])
    if params[:commit]=="Accept"
      flash.keep[:success] = "You have successfully accepted one challenge"
      @match.update_attributes(state: "pending")
      redirect_to :controller => :matches, :action=> 'challenge'
    end

    if params[:commit]=="Refuse"
      flash.keep[:success] = "You have successfully refused one challenge"
      @match.destroy
      redirect_to :controller => :matches, :action=> 'challenge'
    end


  end

  def result
    @matches = Match.where(" player1 = ? AND state = 'pending' AND mDate <= ?",session[:current_user_id],Date.today)
    respond_to do |format|
      format.html 
    end
	end

  def edit
    @match = Match.find(params[:id])
    session[:return_to] ||= request.referer

  end

  def update
    @match = Match.find(params[:id])
    respond_to do |format|
      if @match.update_attributes(params[:match])
      @match.update_attributes(state: "Finished")
      flash.keep[:success] = "One match has been successfully updated"
      @user = User.find(@match.winner)
      @user.add_point
        format.html { redirect_to session[:return_to] }
      else
        format.html { render action: "edit" }
     
      end
    end
  end


  def create
    @match = Match.new(params[:match])
  end

  def history

    @matches = Match.where(" (player1 = ? or player2 = ? )AND state = 'Finished'",session[:current_user_id],session[:current_user_id]).order("mDate ASC")
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
  end
end
