FROM debian:bookworm-slim as build
WORKDIR /ecoventure
COPY . .

RUN apt-get update
RUN apt-get install -y ruby
RUN ruby scripts/render_all_templates.rb

FROM nginx:latest
COPY --from=build /ecoventure/site/ /usr/share/nginx/html/
