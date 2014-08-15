require 'Proposition'

class JukeboxController < ApplicationController
	require 'pqueue'
	
	def queue
		@@queue ||= new_queue
	end

	def vote
		proposition = Proposition.new
		proposition.video_id = params[:video_id]
		proposition.title = params[:title]
		proposition.votes = 1
		proposition.proposed_date = DateTime.now

		queue.push(proposition)

		render json: ""
	end

	def take
		render json: queue.pop
	end


	def reset
		@@queue = new_queue
		render json: ""
	end

	private
	def new_queue
		PQueue.new { |a,b| a.votes > b.votes }
	end

end
