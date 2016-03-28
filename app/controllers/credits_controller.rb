class CreditsController < ApplicationController
	before_action :set_client
	before_action :set_credit, except: [:create]

	def create
		@credit = @client.credits.create(credit_params)
		redirect_to @client
	end

	def destroy
		if @credit.destroy
			flash[:success] = "Todo List item was deleted."
		else
			flash[:error] = "Todo List item could not be deleted."
		end
		redirect_to @client
	end

	def complete
		@credit.update_attribute(:completed_at, Time.now)
		redirect_to @client, notice: "Credits completed"
	end

	private

	def set_client
		@client = Client.find(params[:client_id])
	end

	def set_credit
		@credit = @client.credits.find(params[:id])
	end

	def credit_params
		params[:credit].permit(:credits, :staff_id)
	end
end
