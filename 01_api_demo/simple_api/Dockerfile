# simple_api/Dockerfile
FROM ruby:3.2.2-slim

# install OS deps for Postgres gems + nodejs (for webpacker/importmap)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential libpq-dev curl nodejs \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# copy only Gemfile for fast bundle-cache rebuilds
COPY Gemfile Gemfile.lock ./
RUN bundle install

# copy your code
COPY . .

EXPOSE 3000

# start the Rails dev server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
