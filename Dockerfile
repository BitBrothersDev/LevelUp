FROM ruby:3.2

# Install nodejs and yarn (for the asset pipeline)
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Set the working directory inside the container
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application into the container
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# The command to run the application
CMD ["rails", "server", "-b", "0.0.0.0"]
