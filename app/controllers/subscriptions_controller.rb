class SubscriptionsController < ApplicationController
  layout 'subscribe'
  before_action :authenticate_user!, except: [:new, :create]

  def new
    if user_signed_in? && current_user.subscribed?
      redirect_to root_path, notice: "You are already subscribed!"
    end
  end

  def create
    Stripe.api_key = Rails.application.credentials.stripe_api_key
    plan_id = params['plan_id']
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]

    customer = if current_user.stripe_customer_id
                 Stripe::Customer.retrieve(current_user.stripe_customer_id)
               else
                 Stripe::Customer.create(email: current_user.email, source: token)
               end

    subscription = customer.subscriptions.create(plan: plan.id)

    options = {
      stripe_customer_id: customer.id,
      stripe_subscription_id: subscription.id,
      subscription: true
    }

    if params[:user][:card_last_four]
      options.merge!(
        card_type: params[:user][:card_type],
        card_last_four: params[:user][:card_last_four],
        card_exp_month: params[:user][:card_exp_month],
        card_exp_year: params[:user][:card_exp_year]
      )
    end

    current_user.update(options)

    redirect_to root_path, notice: 'Your subscription was setup successfully!'
  end

  def destroy
    Stripe.api_key = Rails.application.credentials.stripe_api_key
    customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil, subscription: false)
    redirect_to root_path, notice: 'Your subscription has been cancelled'
  end
end
