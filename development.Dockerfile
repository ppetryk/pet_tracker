# Select the ruby version
FROM ruby:3.3

# Set up the current folder
WORKDIR /usr/src/pet_tracker

# Copy Gemfiles and install the dependencies
COPY Gemfile* .
RUN bundle install

# Copy the application
COPY . .

# Run the server
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
