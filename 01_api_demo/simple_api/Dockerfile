# 01_api_demo/simple_api/Dockerfile

# ─── Stage 1: build your gems ────────────────────────────────────────────────
FROM ruby:3.2.2-slim AS builder

# Install build-time deps and clean caches
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential libpq-dev nodejs curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only the Gemfiles and install production gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test' \
 && bundle install --jobs 4 --retry 3

# Copy just your app code
COPY app/    ./app
COPY bin/    ./bin
COPY config/ ./config
COPY db/     ./db
COPY lib/    ./lib
COPY public/ ./public
COPY Rakefile  ./
COPY config.ru ./

# ─── Stage 2: runtime image ────────────────────────────────────────────────
FROM ruby:3.2.2-slim

# Install only runtime deps and clean caches
RUN apt-get update \
 && apt-get install -y --no-install-recommends libpq-dev nodejs curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Pull in your gems from the builder
COPY --from=builder /usr/local/bundle /usr/local/bundle

# Pull in only your application code
COPY --from=builder /app /app

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
