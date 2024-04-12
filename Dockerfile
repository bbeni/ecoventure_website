FROM ruby:3.3.0-bookworm as build
WORKDIR /ecoventure
COPY . .

RUN gem install bundler
RUN bundle
RUN ruby scripts/render_all_templates.rb

FROM nginx:latest
WORKDIR /usr/share/nginx/html
COPY --from=build /ecoventure/site/ .
RUN cp home.html index.html

