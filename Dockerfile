FROM bitwalker/alpine-elixir-phoenix:1.8.1
MAINTAINER David Martin <davidmartingarcia0@gmail.com>
ARG DATABASE_URL=ecto://USER:PASS@HOST/DATABASE
ARG SECRET_KEY_BASE=secretkeybase

# Set exposed ports
EXPOSE 4000
WORKDIR /app

ENV DATABASE_URL=$DATABASE_URL
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE
ENV PORT=4000 MIX_ENV=prod

# Cache elixir deps
RUN mix local.hex --force && \
    mix local.rebar --force
ADD mix.exs mix.lock ./
RUN mix do deps.get, deps.compile


# Same with npm deps
ADD assets/package.json ./assets/package.json
RUN cd assets && npm install

ADD . .

# Use for frontend versions - Run frontend build, compile, and digest assets
# RUN npm run deploy && \
#    mix do compile, phx.digest

RUN mix compile

ENTRYPOINT []
CMD ["mix", "phx.server"]
